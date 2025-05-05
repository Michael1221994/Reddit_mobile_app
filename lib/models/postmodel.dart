import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class postData{
  String? title;
  String? text;
  String? post_type;
  //DateTime? posted_when;
  String? sub_id;
  String? user_id;
  String? image_location;
  String? video_location;
  String? link;
  String? poll_question;
  String? poll1;
  String? poll2;
  Map<int, String>? pollOptions;
  int? pollDurationDays;
  XFile? image;

  postData({
    
    this.title,
    this.text,
    this.post_type,
    //this.posted_when,
    this.sub_id,
    this.user_id,
    this.image_location,
    this.video_location,
    this.link,
    this.poll_question,
    this.poll1,
    this.poll2,
    this.pollOptions,
    this.pollDurationDays,
    this.image
  });
}