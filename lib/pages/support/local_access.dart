import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io' show Platform;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:get/get.dart';

class LocalAccessController extends GetxController {
  final cameraController = MobileScannerController();
  final scannedData = Rxn<String>();
  final cameraPermissionGranted = false.obs;
  final qrCodeNotFound = true.obs;
  final isTorchOn = false.obs;
  final isSupportedPlatform = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkPlatform();
    if (isSupportedPlatform.value) {
      _getCameraPermission();
    }
  }

  void _checkPlatform() {
    if (!Platform.isAndroid && !Platform.isIOS) {
      isSupportedPlatform.value = false;
    } else {
      isSupportedPlatform.value = true;
    }
  }

  Future<void> _getCameraPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      cameraPermissionGranted.value = await _requestCameraPermission();
      if (!cameraPermissionGranted.value) {
        return;
      }
    } else {
      cameraPermissionGranted.value = true; // For other platforms, assume permission is granted or not needed
    }
  }

  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.camera.request();
      return result.isGranted;
    }
  }

  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      scannedData.value = barcodes.first.rawValue;
      qrCodeNotFound.value = false;
      cameraController.stop();
      _showScannedDataDialog(barcodes.first.rawValue);
    } else {
      qrCodeNotFound.value = true;
    }
  }

  void toggleTorch() {
    isTorchOn.value = !isTorchOn.value;
    cameraController.toggleTorch();
  }

  void _showScannedDataDialog(String? qrCodeData) {
    if (qrCodeData != null) {
      Get.dialog(
        AlertDialog(
          title: const Text('Scanned QR Code'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Data:'),
                Text(qrCodeData),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Copy'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: qrCodeData));
                Get.back();
                cameraController.start();
                Get.snackbar('Copied', 'QR Code copied to clipboard');
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
                cameraController.start();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}

class LocalAccess extends StatelessWidget {
  LocalAccess({super.key});

  final LocalAccessController controller = Get.put(LocalAccessController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isSupportedPlatform.value) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            title: const Text(''),
            centerTitle: false,
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'This application feature is only supported on Android and iOS devices.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }

      if (!controller.cameraPermissionGranted.value) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            title: const Text(''),
            centerTitle: false,
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Camera permission not granted. Please enable camera permission in app settings to use the QR Scanner.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          title: const Text(''),
          centerTitle: false,
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: controller.cameraController,
              fit: BoxFit.cover,
              onDetect: controller.onDetect,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: ShapeDecoration(
                    shape: QrScannerOverlayShape(
                      borderColor: Colors.grey[300]!,
                      borderRadius: 20,
                      borderLength: 20,
                      borderWidth: 5,
                      cutOutSize: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: const Text(
                'SCAN TO CONNECT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: const Text(
                'Scan the QR code on the device to connect the device.\nIf there is no QR code or the code cannot be identified,\nplease tap “Manual Connection”.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Obx(() => controller.qrCodeNotFound.value
                ? Positioned(
                    bottom: 100,
                    left: 20,
                    right: 20,
                    child: Center(
                      child: Text(
                        'QR code not found',
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Manual Connection'),
              ),
            ),
            Positioned(
              bottom: 200,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: FloatingActionButton(
                onPressed: controller.toggleTorch,
                backgroundColor: Colors.blue,
                child: Obx(() => Icon(
                      controller.isTorchOn.value ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;
  final double cutOutBottomOffset;

  const QrScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.borderRadius = 0.0,
    this.borderLength = 30.0,
    this.cutOutSize = 250.0,
    this.cutOutBottomOffset = 0.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();

    final width = rect.width;
    final height = rect.height;

    final cutOutRect = Rect.fromCenter(
      center: rect.center.translate(0, cutOutBottomOffset),
      width: cutOutSize,
      height: cutOutSize,
    );

    path.addRect(rect);

    void drawBorder(
        Path path, Rect rect, double x, double y, bool isHorizontal) {
      path.moveTo(x, y);
      isHorizontal
          ? path.lineTo(x + borderLength, y)
          : path.lineTo(x, y + borderLength);
    }

    path.addRect(cutOutRect);
    final cutOutArea = Path()
      ..addRect(cutOutRect)
      ..fillType = PathFillType.evenOdd;

    path = Path.combine(PathOperation.intersect, path, cutOutArea);

    // Top left corner
    drawBorder(path, cutOutRect, cutOutRect.left, cutOutRect.top, true);
    drawBorder(path, cutOutRect, cutOutRect.left, cutOutRect.top, false);

    // Top right corner
    drawBorder(path, cutOutRect, cutOutRect.right, cutOutRect.top, true);
    drawBorder(path, cutOutRect, cutOutRect.right, cutOutRect.top, false);

    // Bottom left corner
    drawBorder(path, cutOutRect, cutOutRect.left, cutOutRect.bottom, true);
    drawBorder(path, cutOutRect, cutOutRect.left, cutOutRect.bottom, false);

    // Bottom right corner
    drawBorder(path, cutOutRect, cutOutRect.right, cutOutRect.bottom, true);
    drawBorder(path, cutOutRect, cutOutRect.right, cutOutRect.bottom, false);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderRect = Rect.fromCenter(
      center: rect.center.translate(0, cutOutBottomOffset),
      width: cutOutSize - borderWidth / 2,
      height: cutOutSize - borderWidth / 2,
    );

    // 1. Draw the Lighter Outer Area
    canvas.drawPath(
      getOuterPath(rect),
      Paint()
        ..color = Colors.grey[300]!.withOpacity(0.5)
        ..style = PaintingStyle.fill,
    );

    // 2. Draw the Transparent Inner Area
    final cutOutPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;
    final cutOutRectForInner = Rect.fromCenter(
      center: rect.center.translate(0, cutOutBottomOffset),
      width: cutOutSize,
      height: cutOutSize,
    );
    canvas.drawRect(cutOutRectForInner, cutOutPaint);

    // 3. Draw White Corners (Borders)
    canvas.drawLine(borderRect.topLeft, borderRect.topLeft + Offset(borderLength, 0), paint);
    canvas.drawLine(borderRect.topLeft, borderRect.topLeft + Offset(0, borderLength), paint);

    canvas.drawLine(borderRect.topRight, borderRect.topRight + Offset(-borderLength, 0), paint);
    canvas.drawLine(borderRect.topRight, borderRect.topRight + Offset(0, borderLength), paint);

    canvas.drawLine(borderRect.bottomLeft, borderRect.bottomLeft + Offset(borderLength, 0), paint);
    canvas.drawLine(borderRect.bottomLeft, borderRect.bottomLeft + Offset(0, -borderLength), paint);

    canvas.drawLine(borderRect.bottomRight, borderRect.bottomRight + Offset(-borderLength, 0), paint);
    canvas.drawLine(borderRect.bottomRight, borderRect.bottomRight + Offset(0, -borderLength), paint);
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth * t,
      borderRadius: borderRadius * t,
      borderLength: borderLength * t,
      cutOutSize: cutOutSize * t,
      cutOutBottomOffset: cutOutBottomOffset * t,
    );
  }
}