import 'createpost_event.dart';
import 'createpost_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<UpdateTitleEvent>((event, emit) {
      emit(state.copyWith(title: event.title));
    });
    
    on<UpdateBodyTextEvent>((event, emit) {
      emit(state.copyWith(bodyText: event.bodyText));
    });
    
    on<AddImageEvent>((event, emit) {
      emit(state.copyWith(image: event.image));
    });
    
    on<RemoveImageEvent>((event, emit) {
      emit(state.copyWith(image: null));
    });
    
    on<ToggleLinkEvent>((event, emit) {
      emit(state.copyWith(link: event.link));
    });
    
    on<TogglePollSectionEvent>((event, emit) {
      emit(state.copyWith(showPollSection: !state.showPollSection));
    });
    
    on<AddPollOptionEvent>((event, emit) {
      final newOptions = List<String>.from(state.pollOptions)..add(event.option);
      emit(state.copyWith(pollOptions: newOptions));
    });
    
    on<RemovePollOptionEvent>((event, emit) {
      final newOptions = List<String>.from(state.pollOptions)..removeAt(event.index);
      emit(state.copyWith(pollOptions: newOptions));
    });
  }
}

/*
class CreatepostBloc extends Bloc<WidgetListEvent, WidgetListState> {
  CreatepostBloc() : super(WidgetListState.initial()) {
    on<addPollEvent>((event, emit){
        emit(WidgetListState([
          ...state.widgets,
          pollWidgetState(event.poll, event.Id)
        ]));      
    });
  

  on<removePollEvent>((event, emit){
    emit (WidgetListState([
      ...state.widgets.where((w) => w.Id != event.Id)
    ]));      
  });
}
}*/