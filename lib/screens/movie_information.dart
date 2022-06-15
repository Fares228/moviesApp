import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MovieInformationScreen extends StatelessWidget {
  const MovieInformationScreen({Key? key, required this.movie}) : super(key: key);
  final MovieDetails movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Image.network(movie.image ,height: 250,fit: BoxFit.fill,)),
            Text(movie.description,
              style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
