import 'package:camera/camera.dart';
import 'package:donasiku/user_interface/Verification/face_verification_screen.dart';
import 'package:flutter/material.dart';
import 'ktp_overlay_pointer.dart';

class KtpCameraScreen extends StatefulWidget {
  const KtpCameraScreen({Key? key}) : super(key: key);

  @override
  _KtpCameraScreenState createState() => _KtpCameraScreenState();
}

class _KtpCameraScreenState extends State<KtpCameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0], // Gunakan kamera belakang
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // LAYER 1: Camera Preview
            Center(child: CameraPreview(_controller!)),

            // LAYER 2: Overlay
            CustomPaint(size: Size.infinite, painter: KtpOverlayPainter()),

            // LAYER 3: UI Elements
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      const Text(
                        'Pastikan E-KTP dalam area terang & terbaca dengan jelas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () async {
                          try {
                            final image = await _controller!.takePicture();
                            // Navigasi ke halaman verifikasi wajah setelah foto diambil
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const FaceVerificationScreen(),
                              ),
                            );
                          } catch (e) {
                            print("Error taking picture: $e");
                          }
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
