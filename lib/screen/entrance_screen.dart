import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/util/word_util.dart';
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
  var _isButtonOkEnabled;
  var _isObscured;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final loginFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isObscured = true;
    _isButtonOkEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    _loginController.text = _login;
    _loginController.selection = TextSelection.fromPosition(TextPosition(offset: _loginController.text.length));
    _loginController.addListener(_showButtonLogin);
    _passwordController.text = _password;
    _passwordController.selection = TextSelection.fromPosition(TextPosition(offset: _passwordController.text.length));
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
                          Container(
                            child:
                            Text('Вход',
                              style:
                              TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03)),
                          Form(
                            child:
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextFormField(
                                      focusNode: loginFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _loginController,
                                      decoration:
                                      InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Ваша почта или логин',
                                        errorText: _errorLoginText,
                                        icon: Icon(Icons.person),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          loginFocusNode.requestFocus();
                                          return 'UserNewScreen.FieldNotEmptyFieldMessage'.tr();
                                        }
                                        String msg;
                                        if (value.contains("@")) {
                                          msg = WordUtil.checkEmail(value);
                                        } else {
                                          msg = WordUtil.checkLoginOrFio(value);
                                        }
                                        if (msg.isNotEmpty) {
                                          loginFocusNode.requestFocus();
                                          return msg;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      obscureText: _isObscured,
                                      focusNode: passwordFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _passwordController,
                                      decoration:
                                        InputDecoration(
                                          suffixIcon: IconButton(
                                            padding: const EdgeInsetsDirectional.only(end: 12),
                                            icon: _isObscured? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _isObscured = !_isObscured;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(),
                                          hintText: 'Пароль',
                                          errorText: _errorLoginText,
                                          icon: Icon(Icons.lock),
                                        ),
                                      validator: (value) {
                                        String msg = WordUtil.checkPassword(value);
                                        if (msg.isNotEmpty) {
                                          passwordFocusNode.requestFocus();
                                          return msg;
                                        }
                                      },
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
                                              _logIn(_login, _password);
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
                                  ]
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
                    ),
            )
    );
  }

  String get _errorLoginText {
    if (_loginController.text.contains("@")) {
      return WordUtil.checkEmail(_loginController.text);
    }
    return WordUtil.checkLoginOrFio(_loginController.text);
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

  void _logIn(String login, String password) {

  }

}

