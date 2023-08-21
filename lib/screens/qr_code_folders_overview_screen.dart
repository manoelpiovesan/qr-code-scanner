import 'package:example_project/models/folder_icon.dart';
import 'package:example_project/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../database/db_utils.dart';

class QRCodeFolderOverviewScreen extends StatefulWidget {
  const QRCodeFolderOverviewScreen({super.key});

  @override
  State<QRCodeFolderOverviewScreen> createState() =>
      _QRCodeFolderOverviewScreenState();
}

class _QRCodeFolderOverviewScreenState
    extends State<QRCodeFolderOverviewScreen> {
  DatabaseUtil db = DatabaseUtil();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.data == null
            ? const Center(
                child: Text('Carregando...'),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (snapshot.data!.length == 0)
                    const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_off_outlined),
                        Text('Não há pastas'),
                      ],
                    )),
                  if (snapshot.data!.length != 0)
                    ListView.builder(
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              AppRoutes.FOLDER_DETAILS_SCREEN,
                              arguments: snapshot.data![index]['id'],
                            );
                            setState(() {});
                          },
                          child: Card(
                            child: ListTile(
                              trailing: const Icon(Icons.east),
                              subtitle: snapshot.data![index]['descricao'] ==
                                      null
                                  ? null
                                  : Text(snapshot.data![index]['descricao']),
                              leading: FolderIcon(snapshot.data![index]['icon'])
                                  .icon(),
                              title: Text(snapshot.data![index]['nome']),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  Positioned(
                      bottom: 20,
                      child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.of(context)
                                .pushNamed(AppRoutes.NEW_FOLDER_FORM);
                            setState(() {});
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.add),
                              Text('Adicionar pasta'),
                            ],
                          )))
                ],
              );
      },
      future: db.getFolders(),
    ));
  }
}
