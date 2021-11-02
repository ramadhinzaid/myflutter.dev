import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zaid_study/photo-filter/filter_selector.dart';
import 'package:zaid_study/photo-filter/photo_preview.dart';

class CameraScreen extends StatefulWidget {
  final bool face;
  final String title, assetFrame;
  final double height, width, borderRadius;
  CameraScreen(
      {this.title = "Pastikan posisi wajah tepat pada frame",
      this.assetFrame = "assets/svg/framewajah.svg",
      this.height = 240.0,
      this.width = 240.0,
      this.borderRadius = 240.0,
      this.face = true});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imgPath;

  ScreenshotController screenshotController = ScreenshotController();

  //filter const
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  // Display camera preview
  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    return Screenshot(
      controller: screenshotController,
      child: CameraPreview(
        cameraController,
        child: ValueListenableBuilder(
            valueListenable: _filterColor,
            builder: (context, value, child) {
              final color = value as Color;
              return Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.5),
                  backgroundBlendMode: BlendMode.color,
                ),
              );
            }),
      ),
    );
  }

  // switch camera mode
  Widget cameraToggle() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
          onPressed: () {
            onSwitchCamera();
          },
          icon: Icon(
            getCameraLensIcons(lensDirection),
            color: Colors.white,
            size: 32,
          ),
          label: Text(
            '',
            // '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  //capture image photo
  onCapture(context) async {
    try {
      await cameraController.takePicture().then((value) {
        print(value);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Preview(imgFile: value),
          ),
        );
      });
    } catch (e) {
      showCameraException(e);
    }
  }

  //capture image photo with screenshot
  onCaptureScreen() async {
    screenshotController.capture().then((value) => {
          print(value),
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => Preview(
          //       imgFile: value,
          //     ),
          //   ),
          // ),
        });
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        if (widget.face) {
          setState(() {
            selectedCameraIndex = 1;
          });
        } else {
          setState(() {
            selectedCameraIndex = 0;
          });
        }
        initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: cameraPreview(),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: _buildFilterSelector(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
      takePicture: () => onCapture(context),
    );
  }

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  }

  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
    print(errorText);
  }
}
