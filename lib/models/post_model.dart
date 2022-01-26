class PostModel {
  String? name;
  String? userID;
  String? postImage;
  String? postText;
  String? dateTime;
  String? profile;

  PostModel({
    required this.name,
    required this.postText,
    required this.postImage,
    required this.userID,
    required this.dateTime,
    required this.profile,

  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postText = json['postText'];
    postImage = json['postImage'];
    userID = json['userID'];
    dateTime = json['dateTime'];
    profile = json['profile'];

  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "postImage": postImage,
      "postText": postText,
      "userID": userID,
      "profile": profile,
      "dateTime" : dateTime,

    };
  }
}
