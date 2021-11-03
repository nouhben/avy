import 'dart:html';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<XFile?> pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    return image;
  }
}
