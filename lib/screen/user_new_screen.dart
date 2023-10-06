import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:score_system/current_data.dart';
import 'package:score_system/screen/participant_tasks_screen.dart';
import 'package:score_system/vocabulary/person_data.dart';
import '../locator.dart';
import '../model/person.dart';
import '../navigation/pass_arguments.dart';
import '../util/word_util.dart';
import '../widget/person_avatar.dart';
import 'package:flutter/foundation.dart';

class UserNewPage extends StatefulWidget {

  static final String ROUTE_NAME = '/user/new';

  @override
  State<StatefulWidget> createState() => UserNewPageState();

}

class UserNewPageState extends State<UserNewPage> {

  String _fio = '';
  String _email = '';
  bool _isButtonOkEnabled = false;
  bool _isParticipate = false;
  final TextEditingController _fioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _fioController.text = _fio;
    _fioController.selection = TextSelection.fromPosition(TextPosition(offset: _fioController.text.length));
    _fioController.addListener(_showButtonOk);
    _emailController.text = _email;
    _emailController.selection = TextSelection.fromPosition(TextPosition(offset: _emailController.text.length));
    _emailController.addListener(_showButtonOk);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          title: CURRENT_USER != PERSON_DUMMY ? Container(
            alignment: Alignment.center,
            child: Text(
              'UserNewScreen.Title'.tr(),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child:
                    Column(
                      children: [
                        Row(
                          children: [
                            PersonAva(),
                            Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02)),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child:
                                    TextField(
                                      controller: _fioController,
                                      // use the getter variable defined above
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'UserNewScreen.UserNameTitle'.tr(),
                                        errorText: _errorFioText,
                                      ),
                                      onChanged: (text) => setState(() => _fio = text),
                                    ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child:
                                    TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'UserNewScreen.EmailNameTitle'.tr(),
                                        errorText: _errorEmailText,
                                      ),
                                      onChanged: (text) => setState(() => _email = text),
                                    ),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            Text('UserNewScreen.Participation'.tr()),
                            Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02)),
                            Switch(
                              onChanged: _toggleSwitch,
                              value: _isParticipate,
                              activeColor: Theme.of(context).colorScheme.secondary,
                              activeTrackColor: Color.fromRGBO(120, 120, 128, 1),
                              inactiveThumbColor: Theme.of(context).colorScheme.primary,
                              inactiveTrackColor: Colors.black12,
                            ),
                          ],
                        ),
                        Text('UserNewScreen.PartDesc'.tr(),
                          style:
                          TextStyle(
                            color: Color.fromRGBO(60, 60, 67, 0.6),
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 50)),
                        Container(
                          alignment: Alignment.centerLeft,
                          child:
                            ElevatedButton(
                              onPressed: !_isButtonOkEnabled ? null : () {
                                _fio = _fioController.text;
                                _email = _emailController.text;
                                _storeInBase(_fio, _email);
                                Navigator.pushNamed(
                                  context,
                                  ParticipantTasksPage.ROUTE_NAME,
                                  arguments: PersonDatesIntervalArguments(
                                      CURRENT_USER,
                                      CURRENT_DATA_MIN,
                                      CURRENT_DATA_MAX
                                  ),
                                );
                              },
                              child: Text('ButtonReady'.tr()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        kDebugMode ?
                            Container(
                              alignment: Alignment.centerLeft,
                              child:
                                ElevatedButton(
                                  onPressed: () {
                                    locator<PersonData>().removeEntity(CURRENT_USER);
                                  },
                                  child: Text('ButtonRemoveUser'.tr()),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                            )
                            : Container(),
                      ],
                    ),
                )
            )
    );
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isParticipate = !_isParticipate ? true : false;
    });
  }

  void _storeInBase(String fio, String email) {
    Person person = Person(id: -1, name: fio, email: email, isParticipant: _isParticipate);
    CURRENT_USER = CURRENT_USER == PERSON_DUMMY ? person : CURRENT_USER;
    locator<PersonData>().addEntity(person);
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

  String get _errorFioText {
    return ScoreUtil.checkLoginOrFio(_fioController.text);
  }

  String get _errorEmailText {
    return ScoreUtil.checkEmail(_emailController.text);
  }

  @override
  void dispose() {
    _fioController.dispose();
    _emailController.dispose();
    super.dispose();
  }


  void _showButtonOk() {
    if (_isButtonOkEnabled && (_errorFioText != null || _errorEmailText.isNotEmpty)) {
      setState(() {
        _isButtonOkEnabled = false;
      });
    } else {
      if (_errorFioText == null && _errorEmailText == null) {
        setState(() {
          _isButtonOkEnabled = true;
        });
      }
    }
  }

}

