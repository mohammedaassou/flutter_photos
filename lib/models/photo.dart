class Photo {
  final String id;
  final String description;
  final String imageUrl;
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.thumbnailUrl,
  });

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'] as String,
      description:
          map['description'] as String? ??
          map['alt_description'] as String? ??
          'No description',
      imageUrl: map['urls']['regular'] as String,
      thumbnailUrl: map['urls']['thumb'] as String,
    );
  }
}
