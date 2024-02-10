// ignore_for_file: avoid_print, camel_case_types, unused_element, implementation_imports, avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ioc_app_demo_1/help/help.dart';

class login {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<User?> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackbar(context, 'Email đã được sử dụng');
      } else {
        print('ERROR: ${e.code}');
        showSnackbar(context, 'Vui lòng kiểm tra lại');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showSnackbar(context, 'KIểm tra lại email hoặc password');
      } else {
        print('ERROR: ${e.code}');
        showSnackbar(context, 'Vui lòng kiểm tra lại');
      }
    }
    return null;
  }

  Future<User?> loginWithGmailAccount() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      print("Signed in: ${user!.displayName}");

      return user;
    } catch (error) {
      print("Error during Google sign in: $error");
      return null;
    }
  }

  Future<List<String>> getDataFromFirestoreByUserID() async {
    try {
      // Thực hiện truy vấn để lấy danh sách giá trị từ một trường cụ thể
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      // Lấy danh sách giá trị từ một trường cụ thể (ví dụ: 'your_field')
      List<String> dataList =
          querySnapshot.docs.map((doc) => doc['userid'] as String).toList();
      print(dataList);
      return dataList;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
