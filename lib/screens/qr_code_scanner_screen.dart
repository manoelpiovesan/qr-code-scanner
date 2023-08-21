import 'package:example_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRCodeDartScanView(
        scanInvertedQRCode: true,
        typeScan: TypeScan.live,

        // if TypeScan.takePicture will try decode when click to take a picture (default TypeScan.live)
        // takePictureButtonBuilder: (context,controller,isLoading){
        // if typeScan == TypeScan.takePicture you can customize the button.
        //    if(loading) return CircularProgressIndicator();
        //    return ElevatedButton(
        //       onPressed:controller.takePictureAndDecode,
        //       child:Text('Take a picture'),
        //    );
        // }
        // resolutionPreset: = QrCodeDartScanResolutionPreset.high,
        // formats: [ // You can restrict specific formats.
        //   BarcodeFormat.QR_CODE,
        //   BarcodeFormat.AZTEC,
        //   BarcodeFormat.DATA_MATRIX,
        //   BarcodeFormat.PDF_417,
        //   BarcodeFormat.CODE_39,
        //   BarcodeFormat.CODE_93,
        //   BarcodeFormat.CODE_128,
        //  BarcodeFormat.EAN_8,
        //   BarcodeFormat.EAN_13,
        // ],
        onCapture: (Result result) {
          print('PEGO! ${result.text}');
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.QR_CODE_RESULT_SCREEN,
            arguments: result.text,
          );
        },
      ),
    );
  }
}
