class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String trailerUrl;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.trailerUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Unknown Title',
      description: json['description']?.toString() ??
          json['desc']?.toString() ??
          'No description available',
      imageUrl: json['imageUrl']?.toString() ?? json['image']?.toString() ?? '',
      trailerUrl: json['trailerUrl']?.toString() ?? 'https://youtu.be/default',
    );
  }
}
