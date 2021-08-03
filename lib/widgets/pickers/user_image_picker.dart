import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 640,
      maxHeight: 480
    );
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 45,
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
      ),
      FlatButton.icon(
        onPressed: _pickImage,
        icon: Icon(
          Icons.image,
        ),
        label: Text('Add image'),
      ),
    ]);
  }
}
