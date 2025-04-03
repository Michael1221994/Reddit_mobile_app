import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_attempt2/createpostbloc/createpost_bloc.dart';
import 'package:reddit_attempt2/createpostbloc/createpost_event.dart';
import 'createpostbloc/createpost_state.dart';

class CreatePostPage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _bodyTextController = TextEditingController();
  final _linkController = TextEditingController();
  final _pollOptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      onChanged: (value) => context.read<PostBloc>().add(UpdateTitleEvent(value))),
                    
                    TextField(
                      controller: _bodyTextController,
                      onChanged: (value) => context.read<PostBloc>().add(UpdateBodyTextEvent(value))),
                    
                    if (state.image != null)
                      Image.file(File(state.image!.path)),
                    
                    if (state.link.isNotEmpty)
                      TextField(controller: _linkController),
                    
                    if (state.showPollSection) _buildPollSection(context, state),
                    
                    _buildActionButtons(context, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPollSection(BuildContext context, PostState state) {
    return Column(
      children: [
        for (var i = 0; i < state.pollOptions.length; i++)
          Row(
            children: [
              Expanded(child: Text(state.pollOptions[i])),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.read<PostBloc>().add(RemovePollOptionEvent(i)),
              ),
            ],
          ),
        TextField(
          controller: _pollOptionController,
          decoration: const InputDecoration(labelText: 'Add poll option'),
          onSubmitted: (value) {
            context.read<PostBloc>().add(AddPollOptionEvent(value));
            _pollOptionController.clear();
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, PostState state) {
    return Row(
      children: [
        IconButton(
          onPressed: () => _pickImage(context),
          icon: const Icon(Icons.photo),
        ),
        IconButton(
          onPressed: () => context.read<PostBloc>().add(TogglePollSectionEvent()),
          icon: const Icon(Icons.poll),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<PostBloc>().add(AddImageEvent(image));
    }
  }
}