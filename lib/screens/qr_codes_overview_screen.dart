import 'package:example_project/database/db_utils.dart';
import 'package:example_project/utils/app_routes.dart';
import 'package:flutter/material.dart';

class QRCodeOverviewScreen extends StatefulWidget {
  const QRCodeOverviewScreen({super.key});

  @override
  State<QRCodeOverviewScreen> createState() => _QRCodeOverviewScreenState();
}

class _QRCodeOverviewScreenState extends State<QRCodeOverviewScreen> {
  DatabaseUtil db = DatabaseUtil();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        return snapshot.data == null || snapshot.data!.length == 0
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Você ainda não escaneou nenhum QR Code.\n Eles ficarão salvos aqui quando vocês os escanear.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ))
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        AppRoutes.QR_CODE_DETAILS_SCREEN,
                        arguments: snapshot.data![index]['id'],
                      );
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const Icon(Icons.qr_code),
                        trailing: IconButton(
                          icon: Icon(snapshot.data![index]['isFavorito'] == 1
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () async {
                            await db
                                .toggleFavorite(snapshot.data![index]['id']);
                            setState(() {});
                          },
                        ),
                        title: Text(snapshot.data![index]['valor']),
                        subtitle: snapshot.data![index]['descricao'] == null
                            ? Text('Clique para adicionar uma descrição.')
                            : Text(snapshot.data![index]['descricao']),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
      },
      future: db.getQRCodes(),
    );
  }
}
