import 'package:image_picker/image_picker.dart';

class CreatepostModel {
 

 
  final List<int> pollIndices = []; // Track added polls
  final ImagePicker _picker = ImagePicker();
  late final XFile? _image;
  final bool showfield=false;
  final int counter = 2; // Already have 2 polls
  final int nextPollIndex = 0;
  final bool built=false;
}