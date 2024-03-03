// ignore_for_file: file_names, prefer_const_constructors, unused_import, unrelated_type_equality_checks

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1 from Quanh'),
      ),
      body: Center(
        child: Text('This is Page Quanh 1'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('This is Page 2'),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Điều gì đó khi nút được nhấn
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Màu đỏ
              ),
              child: Text('Nhấn vào đây'),
            ),
          ),
          SizedBox(height: 20), // Khoảng cách giữa nút và danh sách

          // Danh sách các Card
          CardItem(
            image:
                'https://firebasestorage.googleapis.com/v0/b/my-ioc-app-demo.appspot.com/o/images%2F1.jpg?alt=media',
            name: 'Người dùng 1',
            time: '2 giờ trước',
          ),
          CardItem(
            image:
                'https://firebasestorage.googleapis.com/v0/b/my-ioc-app-demo.appspot.com/o/images%2F2.jpg?alt=media',
            name: 'Người dùng 2',
            time: '5 giờ trước',
          ),
          CardItem(
            image:
                'https://firebasestorage.googleapis.com/v0/b/my-ioc-app-demo.appspot.com/o/images%2F3.jpg?alt=media',
            name: 'Người dùng 2',
            time: '5 giờ trước',
          ),
        ],
      ),
    );
  }
}

class ImageListFromStorage extends StatelessWidget {
  const ImageListFromStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List from Firebase Storage'),
      ),
      body: FutureBuilder(
        future: getImagesList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            List<String> imageList = snapshot.data as List<String>;

            return ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Image ${index + 1}'),
                  onTap: () {
                    // Handle when a list item is tapped
                    // You can navigate to a new page to display the selected image
                  },
                );
              },
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<String>> getImagesList() async {
    List<String> imageList = [];

    // Replace 'path/to/your/folder' with the actual path to your folder in Firebase Storage
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('gs://my-ioc-app-demo.appspot.com/1');
    final ListResult result = await ref.listAll();

    for (final item in result.items) {
      imageList.add(item.fullPath);
    }

    return imageList;
  }
}

Future<String> getImages() {
  // Replace 'path/to/your/folder' with the actual path to your folder in Firebase Storage
  final ref = firebase_storage.FirebaseStorage.instance
      .ref('gs://my-ioc-app-demo.appspot.com')
      .child('images')
      .child('hihi.jpg');
  final result = ref.getDownloadURL();

  return result;
}

class CardItem extends StatelessWidget {
  final String image;
  final String name;
  final String time;

  const CardItem({
    Key? key,
    required this.image,
    required this.name,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
        ),
        title: Text(name),
        subtitle: Text(time),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nút thứ nhất được nhấn
              },
              child: Text('Nút 1'),
            ),
            SizedBox(width: 8), // Khoảng cách giữa hai nút
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nút thứ hai được nhấn
              },
              child: Text('Nút 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Danh sách từ Firestore'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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

class FirestoreListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('history').snapshots(),
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
                  title: Text(data['userid']),
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
              Text('UserID: ${data['userid']}'),
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
