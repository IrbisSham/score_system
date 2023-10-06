import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/util/word_util.dart';
import 'package:score_system/vocabulary/person_data.dart';
import '../component/line.dart';
import '../locator.dart';
import '../model/person.dart';

class EntrancePage extends StatefulWidget {

  static final String ROUTE_NAME = '/entrance';

  @override
  State<StatefulWidget> createState() => EntrancePageState();

}

class EntrancePageState extends State<EntrancePage> {

  String _login = '';
  String _password = '';
  bool _isLogin = true;
  bool _isButtonOkEnabled = false;
  bool _isParticipate = false;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loginController.text = _login;
    _loginController.selection = TextSelection.fromPosition(TextPosition(offset: _loginController.text.length));
    _loginController.addListener(_showButtonLogin);
    _passwordController.text = _password;
    _passwordController.addListener(_showButtonLogin);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          title: CURRENT_USER != PERSON_DUMMY ? Container(
            alignment: Alignment.center,
            child: Text(
              'EntranceScreen.Title'.tr(),
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
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05)),
                        Container(
                          child: Container(
                            child:
                              Text('Вход',
                              style:
                                TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03)),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child:
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child:
                                    Text('Ваша почта или логин',
                                      style:
                                      TextStyle(fontSize: 18,
                                      ),
                                    ),
                                ),
                                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.005)),
                                Container(
                                  child:
                                    TextField(
                                      controller: _loginController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'user@gmail.com',
                                        errorText: _errorLoginText,
                                      ),
                                      onChanged: (text) => setState(() => _login = text),
                                    ),
                                ),
                              ],
                            ),
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01)),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child:
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child:
                                Text('Пароль',
                                  style:
                                  TextStyle(fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.005)),
                              Container(
                                child:
                                TextField(
                                  controller: _passwordController,
                                  obscureText: false,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '*****',
                                    errorText: _errorPasswordText,
                                  ),
                                  onChanged: (text) => setState(() => _password = text),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01)),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.04,
                          color: MaterialStateColor
                            .resolveWith((states) => Theme.of(context).colorScheme.primary),
                          child:
                          GestureDetector(
                              onTap: (){
                                if (_isButtonOkEnabled) {
                                  print("Container clicked: $_isButtonOkEnabled");
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration:
                                BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1, style: BorderStyle.solid),
                                    bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1, style: BorderStyle.solid),
                                    right: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1, style: BorderStyle.solid),
                                    left: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1, style: BorderStyle.solid),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:
                                Text("ВОЙТИ",
                                  style:
                                  TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                  ),
                                ),
                              )
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01)),
                        GestureDetector(
                            onTap: (){
                              print("Not remember password");
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: 
                                Text("Я не помню свой пароль",
                                  style:
                                  TextStyle(fontSize: 18,
                                  ),
                                ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          alignment: Alignment.center,
                            child:
                              Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.125,
                                  child: HorizontalDashedLine(dashWidth: 2,),
                                  // alignment: Alignment.centerLeft,
                              ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                  alignment: Alignment.center,
                                  child: Text('ИЛИ',
                                    style:
                                    TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                      ,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.125,
                                  child: HorizontalDashedLine(dashWidth: 2,),
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03)),
                        GestureDetector(
                            onTap: (){
                              print("Registerted");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration:
                                BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                    bottom: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                    right: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                    left: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              child: Text("ЗАРЕГИСТРИРОВАТЬСЯ"),
                              ),
                            ),
                     ]
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

  String get _errorLoginText {
    if (_loginController.text.contains("@")) {
      return ScoreUtil.checkEmail(_loginController.text);
    }
    return ScoreUtil.checkLoginOrFio(_loginController.text);
  }

  String get _errorPasswordText {
    if (_passwordController.text.isEmpty)
      return 'UserNewScreen.FieldNotEmptyFieldMessage'.tr();
    return "";
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }


  void _showButtonLogin() {
    if (_errorLoginText.isEmpty && _errorPasswordText.isEmpty) {
      setState(() {
        _isButtonOkEnabled = true;
      });
    } else {
      setState(() {
        _isButtonOkEnabled = false;
      });
    }
  }

}

