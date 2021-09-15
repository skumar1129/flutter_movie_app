class PopularMovies {
  final int id;
  final String title;
  final String posterPath;

  PopularMovies({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory PopularMovies.fromJson(Map<String, dynamic> json) {
    return PopularMovies(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}
