class MovieImages {
  final List<dynamic> posters;

  MovieImages({
    required this.posters,
  });

  factory MovieImages.fromJson(Map<String, dynamic> json) {
    return MovieImages(posters: parseResponse(json['posters']));
  }
}

List<dynamic> parseResponse(dataItems) {
  return dataItems.map((json) => json['file_path']).toList();
}
