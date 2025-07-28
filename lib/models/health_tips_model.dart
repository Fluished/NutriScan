class HealthArticle {
  final String title;
  final String description;
  final String imageUrl;

  HealthArticle({required this.title, required this.description, required this.imageUrl});

  factory HealthArticle.fromJson(Map<String, dynamic> json) {
    return HealthArticle(
      title: json['Title'] ?? 'No Title',
      description: json['Description'] ?? 'No Description',
      imageUrl: json['ImageUrl'] ?? 'https://via.placeholder.com/150',
    );
  }
}
