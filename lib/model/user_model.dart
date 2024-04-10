class UserModel {
  String? userId;
  String? phoneNumber;
  String? verified;
  String? fullName;
  String? username;
  String? profilePic;
  List? subscribedChannels;
  dynamic createdAt;

  UserModel({
    this.userId,
    this.phoneNumber,
    this.verified,
    this.fullName,
    this.username,
    this.profilePic,
    this.subscribedChannels,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      phoneNumber: json["phoneNumber"],
      verified: json["verified"],
      fullName: json["fullName"],
      username: json["username"],
      profilePic: json["profilePic"],
      subscribedChannels: json["subscribedChannels"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["userId"] = userId;
    data["phoneNumber"] = phoneNumber;
    data["verified"] = verified;
    data["fullName"] = fullName;
    data["username"] = username;
    data["profilePic"] = profilePic;
    data["subscribedChannels"] = subscribedChannels;
    data["createdAt"] = createdAt;
    return data;
  }
}
