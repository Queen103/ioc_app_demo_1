// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> getUserById(String userId) async {
  try {
    // Thực hiện truy vấn để lấy user với điều kiện userId
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(
            'users') // Thay 'users' bằng tên của collection chứa thông tin user
        .where('userid', isEqualTo: userId)
        .get();

    // Nếu có kết quả, trả về user đầu tiên (do userId nên nên chỉ có một user hoặc không có gì)
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      // Nếu không tìm thấy user với userId tương ứng
      print('User with userId $userId not found.');
      return null;
    }
  } catch (error) {
    print('Error getting user by userId: $error');
    return null;
  }
}
