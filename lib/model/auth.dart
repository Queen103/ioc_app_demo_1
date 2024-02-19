// ignore_for_file: unused_import; camel_case_types, prefer_interpolation_to_compose_strings, avoid_print

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ioc_app_demo_1/db/user.dart';

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

  Future<void> loadUser() async {
    Map<String, dynamic>? userData = await getUserById(_userid!);

    _userid = userData?['userid'];
    _fullname = userData?['fullname'];
    _gmail = userData?['gmail'];
    _birth = userData?['birth'];
    _phonenumber = userData?['phonenumber'];
    _room = userData?['room'];
    _active = userData?['isblock'];
    _admin = userData?['ismanager'];
    print("Reload dữ liệu thành công");
    notifyListeners();
  }
}

void display() {}
