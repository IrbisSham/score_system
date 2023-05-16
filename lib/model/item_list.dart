import 'package:flutter/material.dart';

class NameColorNotify extends ChangeNotifier {

  NameColorNotify(this._name, this._color);

  int selectedIndex = 0; // to know active index
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  void toggleSelected(int index) {
    selectedIndex = index;

    notifyListeners(); // To rebuild the Widget
  }

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  Color getColor() {
    return _color;
  }
}

class DateTimeNameColor {

  DateTimeNameColor(this._date, this._name, this._color);

  DateTime _date;
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  DateTime getDate() {
    return _date;
  }

  Color getColor() {
    return _color;
  }
}

class IntNameColor {

  IntNameColor(this._value, this._name, this._color);

  int _value;
  String _name;
  Color _color;

  String getName() {
    return _name;
  }

  int getValue() {
    return _value;
  }

  Color getColor() {
    return _color;
  }

  void setColor(Color color) {
    this._color = color;
  }

  void setValue(value) {
    this._value = value;
  }

  void setName(name) {
    this._name = name;
  }
}