// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('List of visiter'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('requirement').get(),
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
                    title: Text(data['userid'] ?? ''),
                    subtitle: Text(data['date'] ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
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
              SizedBox(height: 16),
              Text('UserID: ${data['userid']}'),
              SizedBox(height: 8),
              Text('Ngày: ${data['date']}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _handleAccept(data);
                      Navigator.pop(
                          context); // Đóng BottomSheet sau khi xử lý sự kiện
                    },
                    child: Text('Đồng ý'),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    onPressed: () {
                      _handleReject(data);
                      Navigator.pop(
                          context); // Đóng BottomSheet sau khi xử lý sự kiện
                    },
                    child: Text('Từ chối'),
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

  void _handleAccept(Map<String, dynamic> data) {
    // Xử lý khi nhấn nút Đồng ý
    print('Accept: ${data['userid']}');
  }

  void _handleReject(Map<String, dynamic> data) {
    // Xử lý khi nhấn nút Từ chối
    print('Reject: ${data['userid']}');
  }
}
