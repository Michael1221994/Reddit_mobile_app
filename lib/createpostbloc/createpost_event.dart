
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

abstract class PostEvent {}

class UpdateTitleEvent extends PostEvent {
  final String title;
  UpdateTitleEvent(this.title);
}

class UpdateBodyTextEvent extends PostEvent {
  final String bodyText;
  UpdateBodyTextEvent(this.bodyText);
}

class AddImageEvent extends PostEvent {
  final XFile image;
  AddImageEvent(this.image);
}

class RemoveImageEvent extends PostEvent {}

class ToggleLinkEvent extends PostEvent {
  final String link;
  ToggleLinkEvent(this.link);
}

class TogglePollSectionEvent extends PostEvent {}

class AddPollOptionEvent extends PostEvent {
  final String option;
  AddPollOptionEvent(this.option);
}

class RemovePollOptionEvent extends PostEvent {
  final int index;
  RemovePollOptionEvent(this.index);
}


/*abstract class WidgetListEvent {}

class addPollEvent extends WidgetListEvent {
  late final Widget widget;
  final String Id; // Unique identifier for each widget
  AddWidgetEvent(this.widget, this.Id);
}

class removePollEvent extends WidgetListEvent {
  final String Id; // Remove by ID
  RemoveWidgetEvent(this.Id);
}*/