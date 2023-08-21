import 'package:flutter/material.dart';

import '../database/db_utils.dart';
import '../utils/app_routes.dart';

class FavoritesQRCodeScreen extends StatefulWidget {
  const FavoritesQRCodeScreen({super.key});

  @override
  State<FavoritesQRCodeScreen> createState() => _FavoritesQRCodeScreenState();
}

class _FavoritesQRCodeScreenState extends State<FavoritesQRCodeScreen> {
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
                  Icon(Icons.heart_broken),
                  SizedBox(height: 10),
                  Text('Não há QR Codes favoritos.'),
                ],
              ))
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.QR_CODE_DETAILS_SCREEN,
                        arguments: snapshot.data![index]['id'],
                      );
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
      future: db.getFavoriteQRCodes(),
    );
  }
}
