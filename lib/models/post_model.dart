class PostModel {
  String? postId;
  String? composer;
  String? postText;
  String? location;
  String? profileImg;
  String? postImg;
  int? likeCount;
  String? commentList;
  DateTime? timeStamp;
  PostModel(
      {this.postId,
      this.composer,
      this.postText,
      this.location,
      this.profileImg,
      this.postImg,
      this.likeCount,
      this.commentList,
      this.timeStamp});
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'composer': composer,
      'postText': postText,
      'location': location,
      'profileImg': profileImg,
      'postImg': postImg,
      'likeCount': likeCount,
      'commentList': commentList,
      'timeStamp': timeStamp,
    };
  }

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        composer = json['composer'],
        postText = json['postText'],
        location = json['location'],
        profileImg = json['profileImg'],
        postImg = json['postImg'],
        likeCount = json['likeCount'],
        commentList = json['commentList'],
        timeStamp = DateTime.parse(json['timeStamp'].toDate().toString());

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        postId: map['postId'],
        composer: map['composer'],
        postText: map['postText'],
        location: map['location'],
        profileImg: map['profileImg'],
        postImg: map['postImg'],
        likeCount: map['likeCount'],
        commentList: map['commentList'],
        timeStamp: DateTime.parse(map['timeStamp'].toDate().toString()));
  }
  toJson() {
    return {
      "postId": postId,
      "composer": composer,
      "postText": postText,
      "location": location,
      "profileImg": profileImg,
      "postImg": postImg,
      "likeCount": likeCount,
      "commentList": commentList,
    };
  }
}
