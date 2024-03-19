// ignore_for_file: avoid_print, unused_import, file_names, unused_local_variable, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ioc_app_demo_1/help/help.dart';
import 'package:ioc_app_demo_1/page/errorPage.dart';
import 'package:ioc_app_demo_1/page/loginPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../db/login.dart';

class SignUpGmail extends StatefulWidget {
  const SignUpGmail({super.key});

  @override
  State<SignUpGmail> createState() => _SignUpGmail();
}

class _SignUpGmail extends State<SignUpGmail> {
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color.fromARGB(214, 255, 214, 64),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgLogin.jpg'), // Đường dẫn tới ảnh
            fit: BoxFit.cover, // Để ảnh đảm bảo đầy đủ không gian của Container
          ),
        ),

        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 216, 205, 216).withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0), // Đặt bán kính bo góc
          ),
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 330,
                  height: 60,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 91, 94, 93).withOpacity(0.9),
                    borderRadius:
                        BorderRadius.circular(50.0), // Đặt bán kính bo góc
                  ),
                  child: const Center(
                    child: Text(
                      "Register with gmail",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          inherit: true),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _phonenumberController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    // Màu sắc của nhãn
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _birthController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range_outlined),
                    labelText: "Select your birth",
                  ),
                  onTap: () async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (pickDate != null) {
                      setState(() {
                        _birthController.text =
                            DateFormat('dd-MM-yyyy').format(pickDate);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 174, 255)
                        .withOpacity(0.9), // Đặt màu nền của nút
                  ),
                  onPressed: () async {
                    try {
                      // Xử lý đăng nhập ở đây
                      String phonenumber = _phonenumberController.text;
                      String birth = _birthController.text;
                      // Tạo một đối tượng Random
                      Random random = Random();

                      // Tạo số ngẫu nhiên từ 0 đến 99
                      String randomNumber = random.nextInt(100000).toString();

                      // Thực hiện xác thực, chuyển đến màn hình chính, v.v.
                      User? user = await login().loginWithGmailAccount();
                      await _user.add({
                        "userid": user?.uid,
                        "isblock": false,
                        "ismanager": false,
                        "gmail": user?.email,
                        "room": "0000",
                        "birth": birth,
                        "fullname": user?.displayName,
                        "phonenumber": phonenumber,
                        "faceid": randomNumber,
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                      showSnackbar(context, 'Vui lòng đăng nhập lại');
                    } catch (e) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ErrorPage()),
                      );
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Text('You Have Account?'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 0, 0)
                          .withOpacity(0.9), // Đặt màu nền của nút
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
