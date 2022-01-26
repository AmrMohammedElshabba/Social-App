class UserModel {
  String? name;
  String? userID;
  String? email;
  String? phone;
  String? bio;
  String? cover;
  String? profile;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.userID,
    required this.cover,
    required this.bio,
    required this.profile,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    userID = json['userID'];
    bio = json['bio'];
    cover = json['cover'];
    profile = json['profile'];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "userID": userID,
      "bio": bio,
      "profile": profile,
      "cover" : cover,
    };
  }
}
