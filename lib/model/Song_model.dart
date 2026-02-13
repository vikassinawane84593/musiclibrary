class Song {
  final int id;
  final String title;
  final String artistName;
  final String albumName;
  final String albumImage;

  Song({
    required this.id,
    required this.title,
    required this.artistName,
    required this.albumName,
    required this.albumImage,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      artistName: json['artist']?['name'] ?? '',
      albumName: json['album']?['title'] ?? '',
      albumImage: json['album']?['cover_medium'] ?? '',
    );
  }
}
