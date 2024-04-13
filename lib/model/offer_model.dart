class OfferModel {
  final String id;
  final bool isSell;
  final String title;
  final String subtitle;
  final String description;
  final String country;
  final String city;
  final List images;
  final List channels;
  final bool isAnonymous;
  final String userId;
  final dynamic createdAt;

  OfferModel({
    required this.id,
    required this.isSell,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.country,
    required this.city,
    required this.images,
    required this.channels,
    required this.isAnonymous,
    required this.userId,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json["id"],
      isSell: json["isSell"],
      title: json["title"],
      subtitle: json["subtitle"],
      description: json["description"],
      country: json["country"],
      city: json["city"],
      images: json["images"],
      channels: json["channels"],
      isAnonymous: json["isAnonymous"],
      userId: json["userId"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["isSell"] = isSell;
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["description"] = description;
    data["country"] = country;
    data["city"] = city;
    data["images"] = images;
    data["channels"] = channels;
    data["isAnonymous"] = isAnonymous;
    data["userId"] = userId;
    data["createdAt"] = createdAt;
    return data;
  }
}
