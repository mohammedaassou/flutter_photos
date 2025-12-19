import 'package:flutter/material.dart';
import 'view/photos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Photo Gallery',
      debugShowCheckedModeBanner: false,

      home: const PhotosPage(),
    );
  }
}
