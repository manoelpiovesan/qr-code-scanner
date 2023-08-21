// ignore_for_file: prefer_const_constructors

import 'package:example_project/screens/folder_create_form_screen.dart';
import 'package:example_project/screens/folder_detail_screen.dart';
import 'package:example_project/screens/home_screen.dart';
import 'package:example_project/screens/qr_code_add_into_folder_screen.dart';
import 'package:example_project/screens/qr_code_details_screen.dart';
import 'package:example_project/screens/qr_code_result_screen.dart';
import 'package:example_project/screens/qr_code_scanner_screen.dart';
import 'package:example_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRCodeSaver',
      theme: ThemeData(
        fontFamily: GoogleFonts.albertSans().fontFamily,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.amber,
        ),
      ),
      home: HomeScreen(),
      routes: {
        AppRoutes.QR_CODE_SCREEN: (context) => QRCodeScannerScreen(),
        AppRoutes.QR_CODE_RESULT_SCREEN: (context) => QRCodeResultScreen(),
        AppRoutes.QR_CODE_DETAILS_SCREEN: (context) => QRCodeDetailScreen(),
        AppRoutes.NEW_FOLDER_FORM: (context) => FolderCreateFormScreen(),
        AppRoutes.FOLDER_DETAILS_SCREEN: (context) =>
            FolderDetailScreen(),
            AppRoutes.ADD_QR_INTO_FOLDER: (context) => AddIntoFolderScreen(),
      },
    );
  }
}
