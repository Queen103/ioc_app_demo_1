// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true, // Đặt title ở giữa
          title: Text(
            'Request to open',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Đặt chữ in đậm
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(209, 248, 15, 209), // Đặt màu nền
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(
                    209, 248, 15, 209), // Màu đầu tiên trong gradient
                Color.fromARGB(255, 15, 223, 238), // Màu thứ hai trong gradient
              ],
              begin: Alignment.topCenter, // Điểm bắt đầu của gradient
              end: Alignment.bottomCenter, // Điểm kết thúc của gradient
              stops: [0.0, 1.0], // Điểm dừng của gradient
              tileMode: TileMode.clamp, // Chế độ lặp lại của gradient
            ),
          ),
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('requirement')
                .where('open', isEqualTo: "1")
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Đã xảy ra lỗi'),
                );
              } else {
                List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        onTap: () {
                          _showModalBottomSheet(context, data);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['url'] ?? ''),
                        ),
                        title: Text(data['room'] ?? ''),
                        subtitle: Text(data['date'] ?? ''),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }

  void _showModalBottomSheet(BuildContext context, Map<String, dynamic> data) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(221, 76, 243, 255),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                data['url'] ?? '',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text('TimeDate: ${data['date']}'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _handleAccept(data);
                      Navigator.pop(
                          context); // Đóng BottomSheet sau khi xử lý sự kiện
                    },
                    child: Text('Accept'),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    onPressed: () {
                      _handleReject(data);
                      Navigator.pop(
                          context); // Đóng BottomSheet sau khi xử lý sự kiện
                    },
                    child: Text('Reject'),
                  ),
                ],
              ),
              // Thêm thông tin chi tiết khác tùy thuộc vào dữ liệu của bạn
            ],
          ),
        );
      },
    );
  }

  void _handleAccept(Map<String, dynamic> data) async {
    // Thực hiện truy vấn để lấy tài liệu với trường id = 12
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('requirement')
        .where('url', isEqualTo: data['url'])
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Nếu có tài liệu thỏa mãn điều kiện
      DocumentSnapshot document = snapshot.docs.first;
      String documentId = document.id; // Lấy document ID của tài liệu

      // Thực hiện cập nhật giá trị của trường "open" thành "0" trong Firestore
      FirebaseFirestore.instance
          .collection(
              'requirement') // Thay 'requirement' bằng tên collection của bạn
          .doc(
              documentId) // Sử dụng document ID để xác định tài liệu cần cập nhật
          .update({'open': '0'}).then((value) {
        print('Update open value successfully');
      }).catchError((error) {
        print('Failed to update open value: $error');
      });
    } else {
      print('No document found');
    }
    // hành động mở cửa

  }

  void _handleReject(Map<String, dynamic> data) async {
    // Thực hiện truy vấn để lấy tài liệu với trường id = 12
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('requirement')
        .where('url', isEqualTo: data['url'])
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Nếu có tài liệu thỏa mãn điều kiện
      DocumentSnapshot document = snapshot.docs.first;
      String documentId = document.id; // Lấy document ID của tài liệu

      // Thực hiện cập nhật giá trị của trường "open" thành "0" trong Firestore
      FirebaseFirestore.instance
          .collection(
              'requirement') // Thay 'requirement' bằng tên collection của bạn
          .doc(
              documentId) // Sử dụng document ID để xác định tài liệu cần cập nhật
          .update({'open': '0'}).then((value) {
        print('Update open value successfully');
      }).catchError((error) {
        print('Failed to update open value: $error');
      });
    } else {
      print('No document found');
    }
  }
}
