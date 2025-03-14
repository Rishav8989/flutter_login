import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io' show Platform;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart'; // For Clipboard


class LocalAccess extends StatefulWidget {
  const LocalAccess({super.key});

  @override
  State<LocalAccess> createState() => _LocalAccessState();
}

class _LocalAccessState extends State<LocalAccess> {
  MobileScannerController cameraController = MobileScannerController();
  String? scannedData;
  bool cameraPermissionGranted = false;
  bool qrCodeNotFound = true; // To control "QR code not found" text visibility

  @override
  void initState() {
    super.initState();
    _getCameraPermission();
  }

  Future<void> _getCameraPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      cameraPermissionGranted = await _requestCameraPermission();
      if (!cameraPermissionGranted) {
        setState(() {});
        return;
      }
    } else {
      cameraPermissionGranted = true;
    }
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    if (!cameraPermissionGranted) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(''), // No title in the center
          centerTitle: false, // Ensure title is not centered
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Camera permission not granted.\nPlease enable camera permission in app settings to use the QR Scanner.',
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(''), // No title in the center
        centerTitle: false, // Ensure title is not centered
        backgroundColor: Colors.grey[900], // Darker AppBar background
        foregroundColor: Colors.white, // White text and icons in AppBar
      ),
      body: Stack( // Use Stack to overlay text and scanner
        children: [
          MobileScanner(
            controller: cameraController,
            fit: BoxFit.cover, // Cover the whole screen
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                setState(() {
                  scannedData = barcodes.first.rawValue;
                  qrCodeNotFound = false; // Hide "QR code not found"
                });
                cameraController.stop(); // Stop scanning after first detection
                _showScannedDataDialog(barcodes.first.rawValue); // Show dialog
              } else {
                setState(() {
                  qrCodeNotFound = true; // Show "QR code not found"
                });
              }
            },
          ),
          Positioned.fill( // Overlay for scan area
            child: IgnorePointer( // Make it non-interactive
              child: Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: Colors.white, // White border
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 5,
                    cutOutSize: MediaQuery.of(context).size.width * 0.6, // Adjust size as needed
                  ),
                ),
              ),
            ),
          ),
          Positioned( // "SCAN TO CONNECT" text
            top: 20,
            left: 20,
            right: 20,
            child: Text(
              'SCAN TO CONNECT',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned( // Instruction text
            top: 60,
            left: 20,
            right: 20,
            child: Text(
              'Scan the QR code on the device to connect the device.\nIf there is no QR code or the code cannot be identified,\nplease tap “Manual Connection”.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          if (qrCodeNotFound) // "QR code not found" text - Conditionally displayed
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Center(
                child: Text(
                  'QR code not found',
                  style: TextStyle(
                    color: Colors.blue[300], // Blue color as in image
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned( // "Manual Connection" button
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // Navigate back on Manual Connection
                Navigator.of(context).pop(); // Use Navigator.pop to go back
              },
              child: const Text('Manual Connection'),
            ),
          ),
        ],
      ),
    );
  }

  void _showScannedDataDialog(String? qrCodeData) {
    if (qrCodeData != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Scanned QR Code'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Data:'),
                  Text(qrCodeData),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Copy'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: qrCodeData));
                  Navigator.of(context).pop();
                  cameraController.start(); // Resume scanning
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('QR Code copied to clipboard')),
                  );
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  cameraController.start(); // Resume scanning
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
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

  // 1. Draw the Darker Outer Area
  canvas.drawPath(
    getOuterPath(rect),
    Paint()
      ..color = Colors.black.withOpacity(0.8) // Darken outside scan area
      ..style = PaintingStyle.fill,
  );

  // 2. Draw the Lighter Inner Area
  final cutoutPaint = Paint()
    ..color = Colors.white.withOpacity(0.2) // Lighter, more transparent white
    ..style = PaintingStyle.fill;
  final cutOutRectForInner = Rect.fromCenter(
    center: rect.center.translate(0, cutOutBottomOffset),
    width: cutOutSize,
    height: cutOutSize,
  );
  canvas.drawRect(cutOutRectForInner, cutoutPaint); 

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