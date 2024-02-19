// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'package:intl/intl.dart';
import 'package:ioc_app_demo_1/db/user.dart';
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
                      _showModalBottomSheet(
                          context,
                          '${context.read<Auth_Provider>().userid}',
                          '${context.read<Auth_Provider>().fullname}',
                          '${context.read<Auth_Provider>().phonenumber}',
                          '${context.read<Auth_Provider>().birth}');
                      context.read<Auth_Provider>().loadUser();
                      print(context.read<Auth_Provider>().fullname);
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

void _showModalBottomSheet(BuildContext context, String userid, String fullname,
    String phone, String birth) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController _fullnameController = TextEditingController();
      final TextEditingController _phoneController = TextEditingController();
      final TextEditingController _birthController = TextEditingController();
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _fullnameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: fullname,
                labelStyle: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
                // Màu sắc của nhãn
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: phone,
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                // Màu sắc của nhãn
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _birthController,
              decoration: InputDecoration(
                icon: Icon(Icons.date_range_outlined),
                labelText: birth,
              ),
              onTap: () async {
                DateTime? pickDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (pickDate != null) {
                  _birthController.text =
                      DateFormat('dd-MM-yyyy').format(pickDate);
                }
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 0, 4, 255), // Màu nền của nút
                    onPrimary: Colors.white, // Màu chữ của nút
                  ),
                  onPressed: () {
                    String newName = (_fullnameController.text.isNotEmpty
                        ? _fullnameController.text
                        : fullname);
                    String newPhone = _phoneController.text.isNotEmpty
                        ? _phoneController.text
                        : phone;
                    String newBirth = (_birthController.text.isNotEmpty
                        ? _birthController.text
                        : birth);
                    updateData(userid, newName, newPhone, newBirth);
                    context.read<Auth_Provider>().loadUser();
                    
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 0, 0, 0), // Màu nền của nút
                    onPrimary:
                        Color.fromARGB(255, 255, 255, 255), // Màu chữ của nút
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
