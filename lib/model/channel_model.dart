class ChannelModel {
  final int id;
  final String title;
  final String subtitle;

  ChannelModel({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["title"] = title;
    data["subtitle"] = subtitle;

    return data;
  }
}
