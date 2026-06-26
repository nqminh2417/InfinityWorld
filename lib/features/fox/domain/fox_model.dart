class FoxModel {
  final String image;
  final String link;

  const FoxModel({required this.image, required this.link});

  factory FoxModel.fromJson(Map<String, dynamic> json) {
    final image = _requiredString(json, 'image');
    final imageUri = Uri.tryParse(image);

    if (imageUri == null ||
        imageUri.host.isEmpty ||
        (imageUri.scheme != 'http' && imageUri.scheme != 'https')) {
      throw const FormatException('Fox image URL is invalid.');
    }

    return FoxModel(image: image, link: _optionalString(json, 'link'));
  }

  static String _requiredString(Map<String, dynamic> json, String key) {
    final value = json[key];

    if (value is! String || value.trim().isEmpty) {
      throw FormatException('Fox response is missing "$key".');
    }

    return value.trim();
  }

  static String _optionalString(Map<String, dynamic> json, String key) {
    final value = json[key];

    return value is String ? value.trim() : '';
  }
}
