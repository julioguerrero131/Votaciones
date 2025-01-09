import 'package:flutter/material.dart';
import 'dart:io';

// Widget para mostrar la imagen en pantalla completa
class ImageViewer extends StatelessWidget {
  final File file;

  const ImageViewer({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.path.split('/').last), // Mostrar el nombre del archivo en la AppBar
      ),
      body: Center(
        child: Image.file(file), // Mostrar la imagen usando Image.file
      ),
    );
  }
}
