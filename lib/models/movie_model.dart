class MovieDetails {
  String image;
  String title;
  String description;
  String rate;

  MovieDetails({
    required this.image,
    required this.title,
    required this.description,
    required this.rate,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    image: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
    title: json['title'],
    description: json['overview'],
    rate: json['vote_average'].toString(),
  );
}
