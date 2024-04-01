import 'dart:convert';

class OfferModel {
  String? id;
  final bool isSell;
  final String title;
  final String subtitle;
  final String description;
  final String countryName;
  final String cityName;
  final List<dynamic> imagesList;
  final List channelList;
  final bool isAnonymous;
  final dynamic createdAt;

  OfferModel({
    this.id,
    required this.isSell,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.countryName,
    required this.cityName,
    required this.imagesList,
    required this.channelList,
    required this.isAnonymous,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json["id"],
      isSell: json["isSell"],
      title: json["title"],
      subtitle: json["subtitle"],
      description: json["description"],
      countryName: json["countryName"],
      cityName: json["cityName"],
      imagesList: json["imagesList"],
      channelList: json["channelList"],
      isAnonymous: json["isAnonymous"],
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
    data["countryName"] = countryName;
    data["cityName"] = cityName;
    data["imagesList"] = imagesList;
    data["channelList"] = channelList;
    data["isAnonymous"] = isAnonymous;
    data["createdAt"] = createdAt;

    return data;
  }
}
