import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ioc_app_demo_1/model/auth.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(209, 31, 226, 252),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('history')
            .where('room', isEqualTo: context.read<Auth_Provider>().room)
            .snapshots(),
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
                  title: Text('Mở cửa bởi ' + data['fullname']),
                  subtitle: Text(data['date']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
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
              Text('Full name: ${data['fullname']}'),
              SizedBox(height: 8),
              Text('Ngày: ${data['date']}'),
              // Thêm thông tin chi tiết khác tùy thuộc vào dữ liệu của bạn
            ],
          ),
        );
      },
    );
  }
}
