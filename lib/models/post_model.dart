class PostModel {
  String? postId;
  String? composer;
  String? composerId;
  String? postText;
  String? location;
  String? profileImg;
  String? postImg;
  List? likedUsers;
  String? commentList;
  DateTime? timeStamp;
  PostModel(
      {this.postId,
      this.composer,
      this.composerId,
      this.postText,
      this.location,
      this.profileImg,
      this.postImg,
      this.likedUsers,
      this.commentList,
      this.timeStamp});
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'composer': composer,
      'composerId': composerId,
      'postText': postText,
      'location': location,
      'profileImg': profileImg,
      'postImg': postImg,
      'likedUsers': likedUsers,
      'commentList': commentList,
      'timeStamp': timeStamp,
    };
  }

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        composer = json['composer'],
        composerId = json['composerId'],
        postText = json['postText'],
        location = json['location'],
        profileImg = json['profileImg'],
        likedUsers = json['likedUsers'],
        postImg = json['postImg'],
        commentList = json['commentList'],
        timeStamp = DateTime.parse(json['timeStamp'].toDate().toString());

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        postId: map['postId'],
        composer: map['composer'],
        composerId: map['composerId'],
        postText: map['postText'],
        location: map['location'],
        profileImg: map['profileImg'],
        likedUsers: map['likedUsers'],
        postImg: map['postImg'],
        commentList: map['commentList'],
        timeStamp: DateTime.parse(map['timeStamp'].toDate().toString()));
  }
  toJson() {
    return {
      "postId": postId,
      "composer": composer,
      "composerId": composerId,
      "postText": postText,
      "location": location,
      "profileImg": profileImg,
      "likedUsers": likedUsers,
      "postImg": postImg,
      "commentList": commentList,
      "timeStamp": timeStamp
    };
  }
}
