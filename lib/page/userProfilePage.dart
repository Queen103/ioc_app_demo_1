// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use

import 'package:ioc_app_demo_1/model/auth.dart';
import 'package:ioc_app_demo_1/page/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// main.dart

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(192, 68, 232, 253),
      body: Center(
        // decoration: BoxDecoration(
        //   color: const Color.fromARGB(255, 216, 205, 216).withOpacity(0.8),
        //   borderRadius: BorderRadius.circular(10.0), // Đặt bán kính bo góc
        // ),
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20), // Đặt độ cong của góc
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              Text(
                'User Profile',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Fullname: ${context.read<Auth_Provider>().fullname}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Email: ${context.read<Auth_Provider>().gmail}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Phone: ${context.read<Auth_Provider>().phonenumber}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Room: ${context.read<Auth_Provider>().room}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Birth of date: ${context.read<Auth_Provider>().birth}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              // Các thông tin khác về người dùng có thể được thêm vào đây
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(204, 18, 241, 36), // Màu nền của nút
                      onPrimary: Colors.white, // Màu chữ của nút
                    ),
                    onPressed: () {
                      context.read<Auth_Provider>().clearCredentials();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 255, 0, 0), // Màu nền của nút
                      onPrimary: Colors.white, // Màu chữ của nút
                    ),
                    onPressed: () {
                      context.read<Auth_Provider>().clearCredentials();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Exit',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
