import 'package:example_project/database/db_utils.dart';
import 'package:flutter/material.dart';

import '../utils/app_routes.dart';
import '../utils/config.dart';

class FolderDetailScreen extends StatefulWidget {
  const FolderDetailScreen({super.key});

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    DatabaseUtil db = DatabaseUtil();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code),
            SizedBox(width: 10),
            Text(Config.APP_NAME),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              db.deleteFolder(id);
              Navigator.of(context).pop();
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: db.getQRCodesByFolderId(id),
          builder: ((context, snapshot) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_off_outlined),
                          SizedBox(height: 10),
                          Text('Pasta vazia!')
                        ]),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
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
                              icon: Icon(
                                  snapshot.data![index]['isFavorito'] == 1
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                              onPressed: () async {
                                await db.toggleFavorite(
                                    snapshot.data![index]['id']);
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
                    }));
          })),
    );
  }
}
