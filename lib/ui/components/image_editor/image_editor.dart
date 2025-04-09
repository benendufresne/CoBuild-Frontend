import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';

// Image editor , using it multiple places ,as :- Create estimate request and Report Damage flow
class ImageEditorExample extends StatefulWidget {
  final XFile file;
  const ImageEditorExample({super.key, required this.file});

  @override
  createState() => _ImageEditorExampleState();
}

class _ImageEditorExampleState extends State<ImageEditorExample> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    loadImage(widget.file);
  }

  void loadAsset(String name) async {
    var data = await rootBundle.load('assets/$name');
    setState(() => imageData = data.buffer.asUint8List());
  }

  /// Load image data from a File or XFile
  void loadImage(XFile file) async {
    setState(() => imageData = File(file.path).readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImageEditor Example"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Single image editor"),
            onPressed: () async {
              var editedImage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageEditor(
                    image: imageData,
                    cropOption: const CropOption(
                      reversible: false,
                    ),
                  ),
                ),
              );

              // replace with edited image
              if (editedImage != null) {
                imageData = editedImage;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
