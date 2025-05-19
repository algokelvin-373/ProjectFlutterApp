import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  bool _isCameraInitialized = false;
  CameraController? controller;
  bool _isBackCameraSelected = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onNewCameraSelected(widget.cameras.first);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    await previousCameraController?.dispose();

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        controller = cameraController;
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  Widget _actionWidget() {
    return FloatingActionButton(
      heroTag: "take-picture",
      tooltip: "Ambil Gambar",
      onPressed: () => _onCameraButtonClick(),
      child: const Icon(Icons.camera_alt),
    );
  }

  Future<void> _onCameraButtonClick() async {
    final navigator = Navigator.of(context);
    final image = await controller?.takePicture();
    navigator.pop(image);
  }

  void _onCameraSwitch() {
    if (widget.cameras.length == 1) return;

    setState(() {
      _isCameraInitialized = false;
    });

    onNewCameraSelected(widget.cameras[_isBackCameraSelected ? 1 : 0]);

    setState(() {
      _isBackCameraSelected = !_isBackCameraSelected;
    });
  }

  AppBar _header() {
    return AppBar(
      title: const Text("Ambil Gambar"),
      actions: [
        IconButton(
          onPressed: () => _onCameraSwitch(),
          icon: const Icon(Icons.cameraswitch),
        ),
      ],
    );
  }

  Widget _mainPage(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _isCameraInitialized
              ? CameraPreview(controller!)
              : const Center(child: CircularProgressIndicator()),
          Align(alignment: const Alignment(0, 0.95), child: _actionWidget()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(appBar: _header(), body: _mainPage(context)),
    );
  }
}
