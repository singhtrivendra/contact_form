import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CaptureButton extends StatefulWidget {
  final Function(File) onImageCaptured; // Callback for when an image is captured

  CaptureButton({required this.onImageCaptured});

  @override
  _CaptureButtonState createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureSelfie() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front, // Use the front camera
      );

      if (image != null) {
        File imageFile = File(image.path);
        widget.onImageCaptured(imageFile); // Pass the image to the callback
      }
    } catch (e) {
      print("Error capturing selfie: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _captureSelfie,
      child: Text('Capture Selfie'),
    );
  }
}
