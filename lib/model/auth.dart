// ignore_for_file: unused_import

// import 'dart:ffi';

import 'package:flutter/material.dart';

class Auth_Provider with ChangeNotifier {
  String? _gmail;
  String? _phonenumber;
  String? _userid;
  String? _fullname;
  String? _birth;
  String? _room;
  bool? _active;
  bool? _admin;

  String? get gmail => _gmail;
  String? get phonenumber => _phonenumber;
  String? get userid => _userid;
  String? get fullname => _fullname;
  String? get birth => _birth;
  String? get room => _room;
  bool? get active => _active;
  bool? get admin => _admin;

  void setCredentials(String userid, String fullname, String gmail,
      String birth, String phonenumber, String room, bool active, bool admin) {
    _userid = userid;
    _fullname = fullname;
    _gmail = gmail;
    _birth = birth;
    _phonenumber = phonenumber;
    _room = room;
    _active = active;
    _admin = admin;
    notifyListeners();
  }

  void clearCredentials() {
    _userid = null;
    _fullname = null;
    _gmail = null;
    _birth = null;
    _phonenumber = null;
    _room = null;
    _active = null;
    _admin = null;
    notifyListeners();
  }
}
