import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? composer;
  String? comment;
  DateTime? timeStamp;
  String? composerId;
  CommentModel({this.composer, this.comment,this.composerId,this.timeStamp});

  CommentModel.fromJson(Map<String, dynamic> json)
      : composer = json['composer'],
        comment = json['comment'],
        composerId = json['composerId'],
        timeStamp = DateTime.parse(json['timeStamp'].toDate().toString());
  toJson() {
    return {"composer": composer, "comment": comment, composerId:"composerId", "timeStamp": timeStamp};
  }
}
