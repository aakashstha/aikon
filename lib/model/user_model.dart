class UserModel {
  final String? userId;
  final String? phoneNumber;
  final String? verified;
  final String? fullName;
  final String? username;
  final String? profilePic;
  final List? subscribedChannels;
  final dynamic createdAt;

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
