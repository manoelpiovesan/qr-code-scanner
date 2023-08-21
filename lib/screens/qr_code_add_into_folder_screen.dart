import 'package:example_project/database/db_utils.dart';
import 'package:flutter/material.dart';

import '../models/folder_icon.dart';
import '../utils/config.dart';

class AddIntoFolderScreen extends StatefulWidget {
  const AddIntoFolderScreen({super.key});

  @override
  State<AddIntoFolderScreen> createState() => _AddIntoFolderScreenState();
}

class _AddIntoFolderScreenState extends State<AddIntoFolderScreen> {
  @override
  Widget build(BuildContext context) {
    final qrId = ModalRoute.of(context)!.settings.arguments as int;
    final DatabaseUtil db = DatabaseUtil();

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
      body: FutureBuilder(
        future: db.getFolders(),
        builder: (context, snapshot) {
          return snapshot.data!.isEmpty
              ? Container(
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_off),
                      Text('Você não possui pastas ainda!'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          db.updateFolderId(
                              id: qrId, folderId: snapshot.data![index]['id']);
                          Navigator.of(context).pop();
                        },
                        child: ListTile(
                          leading: const Icon(Icons.east),
                          title: Text(snapshot.data![index]['nome']),
                          trailing:
                              FolderIcon(snapshot.data![index]['icon']).icon(),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
