import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/vocabulary/person_data.dart';
import '../locator.dart';
import '../model/person.dart';
import '../widget/person_avatar.dart';
import 'package:flutter/foundation.dart';

class UserNewPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => UserNewPageState();

}

class UserNewPageState extends State<UserNewPage> {
  
  static final String ROUTE_NAME = '/user/new';
  String _fio = '';
  String _email = '';
  bool _isParticipate = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _fioController = TextEditingController(
      text: _fio,
    );
    TextEditingController _emailController = TextEditingController(
      text: _email,
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          title: CURRENT_USER != PERSON_DUMMY ? Container(
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.userNewScreenTitle,
              style:
              TextStyle(fontSize: 24,
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
            ),
          ) : Container(),
        ),
        body:
            Center(
              child:
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 30)),
                    PersonAva(),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    TextFormField(
                      controller: _fioController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.userNameTitle,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      validator: (value) => _validateEmail(value),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.emailNameTitle,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context)!.userNewScreenParticipation),
                        Switch(
                          onChanged: _toggleSwitch,
                          value: _isParticipate,
                          activeColor: Color.fromRGBO(52, 199, 89, 1),
                          activeTrackColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Color.fromRGBO(120, 120, 128, 1),
                        ),
                        Text(AppLocalizations.of(context)!.userNewScreenPartDesc,
                          style:
                          TextStyle(
                            color: Color.fromRGBO(60, 60, 67, 0.6),
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 50)),
                        ElevatedButton(
                          onPressed: () {
                            _fio = _fioController.value.text;
                            _email = _emailController.value.text;
                            _storeInBase(_fio, _email);
                          },
                          child: Text(AppLocalizations.of(context)!.buttonReady),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        kDebugMode ?
                          ElevatedButton(
                            onPressed: () {
                              locator<PersonData>().removeEntity(CURRENT_USER);
                            },
                            child: Text('Remove current user'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        : Container(),
                      ],
                    )
                  ],
                ),
            )
    );
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isParticipate = !_isParticipate ? true : false;
    });
  }

  String? _validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return AppLocalizations.of(context)!.emailNameValidatorMessage;
    else
      return null;
  }

  // TODO: Register on Server
  Future _registerOnServer (String fio, String email) async {
    throw UnsupportedError(AppLocalizations.of(context)!.unsupportedError);
  }

  void _storeInBase(String fio, String email) {
    Person person = Person(id: -1, name: fio);
    CURRENT_USER = CURRENT_USER == PERSON_DUMMY ? person : CURRENT_USER;
    locator<PersonData>().addEntity(person);
    if (_email.isNotEmpty) {
      _registerOnServer(_fio, _email);
    }
    // Navigator.pushNamed(
    //   context,
    //   ParticipantTasksPage.ROUTE_NAME,
    //   arguments: PersonDatesIntervalArguments(
    //       CURRENT_USER,
    //       CURRENT_DATA_MIN,
    //       CURRENT_DATA_MAX
    //   ),
    // );
  }

}

