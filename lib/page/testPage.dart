import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ioc_app_demo_1/model/auth.dart';
import 'package:provider/provider.dart';

class testFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('history')
            .where('room', isEqualTo: context.read<Auth_Provider>().room)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return FutureBuilder(
                future: _getFullnames(data['faceids']),
                builder:
                    (context, AsyncSnapshot<List<String>> fullnamesSnapshot) {
                  if (fullnamesSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (fullnamesSnapshot.hasError) {
                    return Text('Error: ${fullnamesSnapshot.error}');
                  }

                  return Card(
                    child: ListTile(
                      onTap: () {
                        _showModalBottomSheet(
                            context, data, fullnamesSnapshot.data ?? []);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['url']),
                      ),
                      title: Text(fullnamesSnapshot.data?.join(', ') ??
                          'Fullname not found'),
                      subtitle: Text(data['date']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> _getFullnames(List<dynamic> faceIds) async {
    List<String> fullnames = [];

    for (String faceId in faceIds) {
      QuerySnapshot fullnameSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('faceid', isEqualTo: faceId)
          .limit(1)
          .get();

      if (fullnameSnapshot.docs.isNotEmpty) {
        fullnames.add(fullnameSnapshot.docs.first['fullname']);
      }
    }

    return fullnames;
  }

  void _showModalBottomSheet(
      BuildContext context, Map<String, dynamic> data, List<String> fullnames) {
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
              Text('UserFaceID: ${fullnames.join(', ')}'),
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
