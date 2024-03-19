// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true, // Đặt title ở giữa
          title: Text(
            'History',
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
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('history').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              return ListView(
                children: snapshot.data!.docs.map((document) {
                  final data = document.data() as Map<String, dynamic>;

                  return Card(
                    child: ListTile(
                      onTap: () {
                        _showModalBottomSheet(context, data);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['url']),
                      ),
                      title: Text('Room: ' + data['room']),
                      subtitle: Text(data['date']),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ));
  }

  void _showModalBottomSheet(BuildContext context, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                data['url'],
                height: 300,
                width: 400,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text('Open by : ${data['fullname']}'),
              SizedBox(height: 8),
              Text('TimeDate: ${data['date']}'),
              // Thêm thông tin chi tiết khác tùy thuộc vào dữ liệu của bạn
            ],
          ),
        );
      },
    );
  }
}
