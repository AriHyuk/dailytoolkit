import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  XFile? _imageFile;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
    setState(() {
      _isReady = true;
    });
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;
    final image = await _controller!.takePicture();
    setState(() {
      _imageFile = image;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ambil Foto")),
      body: !_isReady
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text("Ambil Foto"),
            onPressed: _takePicture,
          ),
          if (_imageFile != null) ...[
            SizedBox(height: 16),
            Text("Hasil Foto:"),
            SizedBox(height: 8),
            Image.file(
              File(_imageFile!.path),
              width: 200,
            ),
          ],
        ],
      ),
    );
  }
}
