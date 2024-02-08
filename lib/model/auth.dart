// ignore_for_file: unused_import

// import 'dart:ffi';

import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _username;
  String? _password;
  String? _gmail;
  String? _phonenumber;
  String? _userid;
  String? _fullname;
  String? _birth;
  String? _room;
  int? _active;
  int? _admin;

  String? get username => _username;
  String? get password => _password;
  String? get gmail => _gmail;
  String? get phonenumber => _phonenumber;
  String? get userid => _userid;
  String? get fullname => _fullname;
  String? get birth => _birth;
  String? get room => _room;
  int? get active => _active;
  int? get admin => _admin;

  void setCredentials(
      String userid,
      String username,
      String fullname,
      String gmail,
      String password,
      String birth,
      String phonenumber,
      String room,
      int active,
      int admin) {
    _userid = userid;
    _username = username;
    _fullname = fullname;
    _gmail = gmail;
    _password = password;
    _birth = birth;
    _phonenumber = phonenumber;
    _room = room;
    _active = active;
    _admin = admin;
    notifyListeners();
  }

  void clearCredentials() {
    _userid = null;
    _username = null;
    _fullname = null;
    _gmail = null;
    _password = null;
    _birth = null;
    _phonenumber = null;
    _room = null;
    _active = null;
    _admin = null;
    notifyListeners();
  }
}
