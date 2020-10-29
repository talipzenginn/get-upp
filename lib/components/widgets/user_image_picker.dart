import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import '../../components/constants.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker({this.imagePickFn});
  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
      maxHeight: 150,
    );
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          radius: 40,
        ),
        FlatButton.icon(
          textColor: kAppBarColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
