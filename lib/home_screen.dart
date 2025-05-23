import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    if (Platform.isWindows) {
      // Simulate image pick on Windows
      setState(() {
        _image = null;
      });
      Navigator.pushNamed(context, '/result', arguments: null);
      return;
    }
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.pushNamed(context, '/result', arguments: _image);
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: const Text('Choose how to upload your skin image:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Future.delayed(
                const Duration(milliseconds: 100),
              ); // Small delay
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Upload from Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Scan'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Upload a skin image', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.file(
                  _image!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showImageSourceDialog,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take or Upload Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
