class Config {
  final String baseUrl;
  final List<dynamic> logoSizes;

  Config({
    required this.baseUrl,
    required this.logoSizes,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      baseUrl: json['secure_base_url'],
      logoSizes: json['logo_sizes'],
    );
  }
}
