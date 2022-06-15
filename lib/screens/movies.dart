import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/genres_model.dart';
import 'movie_information.dart';

class MoviesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieCubit()..getCategories(),
        child: BlocBuilder<MovieCubit, MovieStates>(
          builder: (context, state) {
            if (state is MovieLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieScreenSuccessState) {
              final movies = state.movies;
              final categories = state.genres;
              return SafeArea(
                child: Column(
                  children: [
                    CategoriesDropMenu(
                      items: categories,
                      onChanged: (value) {
                        context.read<MovieCubit>().getMoviesByGenres(true);
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieInformationScreen(movie: movies[index]),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //Image.network(movies[index].image),
                            //Text(movies[index].title),
                            //Text(movies[index].rate),
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 300,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Image.network(movies[index].image,
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            movies[index].rate,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 7),
                                      width: double.infinity,
                                      color: Colors.black.withOpacity(.7),
                                      child: Text(
                                        movies[index].title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: context.read<MovieCubit>().getCategories,
                  child: const Text('Error, Try again!'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}




class CategoriesDropMenu extends StatefulWidget {
  const CategoriesDropMenu({Key? key, required this.onChanged, required this.items})
      : super(key: key);
  final List<Genre> items;
  final Function(Genre) onChanged;

  @override
  State<CategoriesDropMenu> createState() => _CategoriesDropMenuState();
}

class _CategoriesDropMenuState extends State<CategoriesDropMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Genre>(
      value: context.read<MovieCubit>().firstGenre,
      items: widget.items.map((e) => DropdownMenuItem(
        value: e,
        child: Text(e.name),
      )).toList(),
      onChanged: (value) {
        context.read<MovieCubit>().firstGenre = value!;
        widget.onChanged(value);
        setState(() {});
      },
    );
  }
}
