import 'package:example_project/database/db_utils.dart';
import 'package:example_project/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class QRCodeResultScreen extends StatelessWidget {
  const QRCodeResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)!.settings.arguments as String;

    DatabaseUtil db = DatabaseUtil();

    void _saveQRCode(valor) {
      db.insertQRCode(valor: valor);
    }

    return Scaffold(
      appBar: AppBar(
          title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code),
          SizedBox(width: 10),
          Text(Config.APP_NAME),
        ],
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Lido: $result'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    _saveQRCode(result);
                    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                  },
                  child: Text('Salvar')),
              SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                  },
                  child: Text('Não salvar')),
            ],
          )
        ],
      ),
    );
  }
}
