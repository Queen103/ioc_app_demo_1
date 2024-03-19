// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true, // Đặt title ở giữa
          title: Text(
            'LIST OF USER',
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
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('ismanager', isEqualTo: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        style:
                            TextStyle(color: Colors.black54), // Màu chữ xám đậm
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
        ));
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
        SnackBar(content: Text('Update Success')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update Fail: $error')),
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
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        centerTitle: true, // Đặt title ở giữa
        title: Text(
          'Information',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Đặt chữ in đậm
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(209, 248, 15, 209), // Đặt màu nền
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(209, 248, 15, 209), // Màu đầu tiên trong gradient
              Color.fromARGB(255, 15, 223, 238), // Màu thứ hai trong gradient
            ],
            begin: Alignment.topCenter, // Điểm bắt đầu của gradient
            end: Alignment.bottomCenter, // Điểm kết thúc của gradient
            stops: [0.0, 1.0], // Điểm dừng của gradient
            tileMode: TileMode.clamp, // Chế độ lặp lại của gradient
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fullname :',
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
              'Birth date:',
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
              'Gmail :',
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
              'Phonenumber :',
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
              'Room :',
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
              'Face ID :',
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
              'Blocked :',
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
