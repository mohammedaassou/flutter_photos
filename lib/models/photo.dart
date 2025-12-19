class Photo {
  final String id;
  final String description;
  final String imageUrl;
  final String thumbnailUrl;
  final int width;
  final int height;

  Photo({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.width,
    required this.height,
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
      width: map['width'] as int,
      height: map['height'] as int,
    );
  }
}
