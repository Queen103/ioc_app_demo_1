// ignore_for_file: avoid_print, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:ioc_app_demo_1/firebase_options.dart';
import 'package:ioc_app_demo_1/model/auth.dart';
import 'package:ioc_app_demo_1/page/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      home: LoginPage(),
    );
  }
}

// void main() {
//   // Giả sử bạn có một đối tượng người dùng
//   User myUser = User(
//       id: '1',
//       fullname: 'john_doe',
//       gmail: 'john@example.com',
//       bod: "12-2-2002",
//       phonenumber: "0321564897",
//       room: "1252");

//   // Chạy ứng dụng và hiển thị trang UserProfilePage
//   runApp(MaterialApp(
//     home: UserProfilePage(user: myUser),
//   ));
// }
