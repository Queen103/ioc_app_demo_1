// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(209, 31, 226, 252), // Đặt màu nền
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              String fullname = users[index]['fullname'];
              String room = users[index]['room'];

              return Card(
                color: Colors.white, // Đặt màu nền của thẻ là trắng
                child: ListTile(
                  title: Text(
                    fullname,
                    style: TextStyle(color: Colors.black87), // Màu chữ đen
                  ),
                  subtitle: Text(
                    'Room: $room',
                    style: TextStyle(color: Colors.black54), // Màu chữ xám đậm
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetailsScreen(user: users[index]),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailsScreen extends StatefulWidget {
  final DocumentSnapshot user;

  UserDetailsScreen({required this.user});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late String _room;
  late bool _isBlock;

  @override
  void initState() {
    super.initState();
    _room = widget.user['room'];
    _isBlock = widget.user['isblock'];
  }

  void _updateRoomAndBlock() {
    FirebaseFirestore.instance.collection('users').doc(widget.user.id).update({
      'room': _room,
      'isblock': _isBlock,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update Thành công')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update thất bại: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String fullname = widget.user['fullname'];
    String birth = widget.user['birth'];
    String gmail = widget.user['gmail'];
    String phonenumber = widget.user['phonenumber'];
    String faceid = widget.user['faceid'];

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Color.fromARGB(
            209, 31, 226, 252), // Đặt màu nền của màn hình là xanh nước
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fullname:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Màu chữ trắng
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              fullname,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Birth:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              birth,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Gmail:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              gmail,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Phone Number:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              phonenumber,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Room:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              initialValue: _room,
              onChanged: (value) {
                setState(() {
                  _room = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Face ID:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              faceid,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Blocked:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Switch(
              value: _isBlock,
              onChanged: (value) {
                setState(() {
                  _isBlock = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateRoomAndBlock,
        child: Icon(Icons.save),
      ),
    );
  }
}
