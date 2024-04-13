class UserModel {
  String? userId;
  String? phoneNum;
  String? verified;
  String? fullName;
  String? username;
  String? profilePic;
  List? subChannels;
  List? favourites;
  List? archives;
  dynamic createdAt;

  UserModel({
    this.userId,
    this.phoneNum,
    this.verified,
    this.fullName,
    this.username,
    this.profilePic,
    this.subChannels,
    this.favourites,
    this.archives,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      phoneNum: json["phoneNum"],
      verified: json["verified"],
      fullName: json["fullName"],
      username: json["username"],
      profilePic: json["profilePic"],
      subChannels: json["subChannels"],
      favourites: json["favourites"],
      archives: json["archives"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["userId"] = userId;
    data["phoneNum"] = phoneNum;
    data["verified"] = verified;
    data["fullName"] = fullName;
    data["username"] = username;
    data["profilePic"] = profilePic;
    data["subChannels"] = subChannels;
    data["favourites"] = favourites;
    data["archives"] = archives;
    data["createdAt"] = createdAt;
    return data;
  }
}
