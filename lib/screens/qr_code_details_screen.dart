import 'package:example_project/components/webview_card.dart';
import 'package:example_project/database/db_utils.dart';
import 'package:example_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../utils/config.dart';

class QRCodeDetailScreen extends StatefulWidget {
  const QRCodeDetailScreen({super.key});

  @override
  State<QRCodeDetailScreen> createState() => _QRCodeDetailScreenState();
}

class _QRCodeDetailScreenState extends State<QRCodeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final DatabaseUtil db = DatabaseUtil();

    final id = ModalRoute.of(context)!.settings.arguments as int;
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
        body: Container(
          width: double.infinity,
          child: FutureBuilder(
            builder: (context, snapshot) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data!['valor'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data!['descricao'] ?? 'Sem descrição'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: WebViewCard(url: snapshot.data!['valor'])),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrettyQr(
                          typeNumber: 3,
                          size: 120,
                          data: snapshot.data!['valor'],
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                        child: ListView(
                      shrinkWrap: true,
                      children: [
                        const ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Acessar link'),
                          // subtitle: Text(snapshot.data!['valor']),
                        ),
                        const ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Editar'),
                        ),
                        if (snapshot.data!['folderId'] == null)
                          GestureDetector(
                            onTap: () async {
                              await Navigator.of(context).pushNamed(
                                AppRoutes.ADD_QR_INTO_FOLDER,
                                arguments: id,
                              );
                              setState(() {});
                            },
                            child: const ListTile(
                              leading: Icon(Icons.drive_folder_upload),
                              title: Text('Adicionar à uma pasta'),
                            ),
                          ),
                        if (snapshot.data!['folderId'] != null)
                          GestureDetector(
                            onTap: () async {
                              await Navigator.of(context).pushNamed(
                                AppRoutes.ADD_QR_INTO_FOLDER,
                                arguments: id,
                              );
                              setState(() {});
                            },
                            child: const ListTile(
                              leading: Icon(Icons.drive_file_move),
                              title: Text('Mover para outra pasta'),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            db.deleteQRCode(id);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.HOME);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.clear, color: Colors.red),
                            title: Text(
                              'Excluir',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              );
            },
            future: db.getQRCodeById(id),
          ),
        ));
  }
}
