class MovieDetails {
  final int budget;
  final String tagline;
  final String overview;
  final String releaseDate;
  final String backdropPath;
  final List<Genre> genres;
  final double popularity;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final String homepage;
  final String posterPath;
  final String title;
  final List<Languages> languages;

  MovieDetails({
    required this.budget,
    required this.tagline,
    required this.overview,
    required this.releaseDate,
    required this.backdropPath,
    required this.genres,
    required this.popularity,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.homepage,
    required this.posterPath,
    required this.title,
    required this.languages,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      budget: json['budget'],
      tagline: json['tagline'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
      genres: parseGenres(json['genres']),
      popularity: json['popularity'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      homepage: json['homepage'],
      posterPath: json['poster_path'],
      title: json['title'],
      languages: parseLanguage(json['spoken_languages']),
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'], name: json['name']);
  }
}

class Languages {
  final String language;

  Languages({required this.language});

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(language: json['english_name']);
  }
}

List<Genre> parseGenres(dataItems) {
  return dataItems.map<Genre>((json) => Genre.fromJson(json)).toList();
}

List<Languages> parseLanguage(dataItems) {
  return dataItems.map<Languages>((json) => Languages.fromJson(json)).toList();
}
