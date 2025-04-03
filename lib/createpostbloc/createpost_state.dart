import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostState {
  final String title;
  final String bodyText;
  final XFile? image;
  final String link;
  final bool showPollSection;
  final List<String> polls;
  final List<String> pollOptions;

  const PostState({
    this.title = '',
    this.bodyText = '',
    this.image,
    this.link = '',
    this.showPollSection = false,
    this.polls = const [],
    this.pollOptions = const [],
  });

  PostState copyWith({
    String? title,
    String? bodyText,
    XFile? image,
    String? link,
    bool? showPollSection,
    List<String>? polls,
    List<String>? pollOptions,
  }) {
    return PostState(
      title: title ?? this.title,
      bodyText: bodyText ?? this.bodyText,
      image: image ?? this.image,
      link: link ?? this.link,
      showPollSection: showPollSection ?? this.showPollSection,
      polls: polls ?? this.polls,
      pollOptions: pollOptions ?? this.pollOptions,
    );
  }
}





class pollWidgetState {
  final Widget widget;
  final String Id;

  pollWidgetState(this.widget, this.Id);
}


class WidgetListState {
  final List<pollWidgetState> widgets;

  WidgetListState(this.widgets);
  factory WidgetListState.initial() => WidgetListState([]);
}