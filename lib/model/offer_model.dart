import 'dart:convert';

class OfferModel {
  final String id;
  final String userId;
  final String title;
  final String subtitle;
  final bool isBuying;
  final String country;
  final String city;
  final int color;
  final String pieces;
  final List<dynamic> images;
  final String channel;
  final bool isAnonymous;
  final dynamic createdAt;

  OfferModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.isBuying,
    required this.country,
    required this.city,
    required this.color,
    required this.pieces,
    required this.images,
    required this.channel,
    required this.isAnonymous,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      subtitle: json["subtitle"],
      isBuying: json["isBuying"],
      country: json["country"],
      city: json["city"],
      color: json["color"],
      pieces: json["pieces"],
      images: List<dynamic>.from(json["images"].map((x) => x)),
      channel: json["channel"],
      isAnonymous: json["isAnonymous"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["userId"] = userId;
    data["title"] = title;
    data["subtitle"] = subtitle;
    data["isBuying"] = isBuying;
    data["country"] = country;
    data["city"] = city;
    data["color"] = color;
    data["pieces"] = pieces;
    data["images"] = List<dynamic>.from(images.map((x) => x));
    data["channel"] = channel;
    data["anonymous"] = isAnonymous;
    data["createdAt"] = createdAt;

    return data;
  }
}
