import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_system/model/person.dart';
import '../navigation/pass_arguments.dart';
import '../screen/participant_tasks_screen.dart';

class PersonAva extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PersonAvaState();
  }
}

class _PersonAvaState extends State<PersonAva> {

  Uint8List? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final Uint8List? image = await galleryImagePicker();
    if (image != null) {
      _image = image;
      setState(() {});
    }
  }

  Future<Uint8List?> galleryImagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (file != null) return await file.readAsBytes(); // convert into Uint8List.
    return null;
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
                ? Image.memory (
                  _image!,
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

}

class AvatarInList extends StatelessWidget {
  final Person _person;
  final DateTime _dtBeg;
  final DateTime _dtEnd;
  const AvatarInList(this._person, this._dtBeg, this._dtEnd);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      // alignment: Alignment.center,
      child:
      InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ParticipantTasksPage.ROUTE_NAME,
            arguments: PersonDatesIntervalArguments(
                _person,
                _dtBeg,
                _dtEnd
            ),
          );
        },
        child:
        CircleAvatar(
          backgroundColor: Colors.white,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:
              _person.avaPath != null
                  ?
              Image.asset(
                _person.avaPath!,
              )
                  :
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
          ),
          radius: 52,
        ),
      ),
    );
  }
}