// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

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

void updateData(String userid, String name, String phone, String birth) async {
  // Thay 'your_collection' và 'your_field' bằng tên của collection và trường bạn đang sử dụng
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  try {
    // Cập nhật dữ liệu trong tất cả các tài liệu có trường 'your_field' bằng giá trị cụ thể
    await collection
        .where('userid', isEqualTo: userid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'fullname': name});
        doc.reference.update({'phonenumber': phone});
        doc.reference.update({'birth': birth});
      });
    });

    print('Dữ liệu đã được cập nhật thành công!');
  } catch (e) {
    print('Có lỗi xảy ra: $e');
  }
}
