class FoxModel {
  final String image;
  final String link;

  FoxModel({required this.image, required this.link});

  factory FoxModel.fromJson(Map<String, dynamic> json) {
    return FoxModel(image: json['image'] ?? '', link: json['link'] ?? '');
  }
}
