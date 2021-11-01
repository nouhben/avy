class AvatarReference {
  final String downloadURL;
  AvatarReference({
    required this.downloadURL,
  });
  factory AvatarReference.fromMap(Map<String, dynamic>? data) {
    final String? _downloadUrl = data!['downloadUrl'];
    if (_downloadUrl != null) {
      return AvatarReference(downloadURL: _downloadUrl);
    }
    return AvatarReference(downloadURL: 'downloadURL');
  }
  Map<String, dynamic> toMap() => {'downloadURL': downloadURL};
}
