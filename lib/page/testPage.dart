// ignore_for_file: file_names, prefer_const_constructors, unused_import

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
  final ref = FirebaseStorage.instance
      .refFromURL('gs://my-ioc-app-demo.appspot.com')
      .child('images')
      .child('hihi.jpg');
  // final image = ref.child('/images');
  // final networkurl = image.child('hihi.jpg');
  final networkurl =
      'https://firebasestorage.googleapis.com/v0/b/my-ioc-app-demo.appspot.com/o/images%2Fimage.jpg?alt=media&token=2ec3e3cc-8a20-4631-8d58-2065dfb8e5c8';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: Image.network(networkurl),
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
