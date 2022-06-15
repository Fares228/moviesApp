class Genre {

  String name;
  String id;

  Genre({required this.name, required this.id});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json['id'].toString(),
    name: json['name'],
  );

}