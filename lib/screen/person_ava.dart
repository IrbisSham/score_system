import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/model/person.dart';

class PersonAva extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PersonAvaState();
  }
}

class _PersonAvaState extends State<PersonAva> {

  File? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: getImage,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 40.0,
            child: CircleAvatar(
              radius: 38.0,
              child: ClipOval(
                child: (_image != null)
                    ? Image.file(_image!)
                    : null,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        if (CurrentUser.person != null)
          Text(CurrentUser.person!.fio()),
      ],
    );
  }

}