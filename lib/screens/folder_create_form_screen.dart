import 'package:example_project/models/folder_icon.dart';
import 'package:flutter/material.dart';

import '../database/db_utils.dart';
import '../utils/config.dart';

class FolderCreateFormScreen extends StatefulWidget {
  const FolderCreateFormScreen({super.key});

  @override
  State<FolderCreateFormScreen> createState() => _FolderCreateFormScreenState();
}

class _FolderCreateFormScreenState extends State<FolderCreateFormScreen> {
  int _folderIcon = 0;

  final TextEditingController _folderNameController = TextEditingController();
  final TextEditingController _folderDescriptionController =
      TextEditingController();

  DatabaseUtil db = DatabaseUtil();

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Pré-visualização'),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: FolderIcon(_folderIcon).icon(),
                subtitle: _folderDescriptionController.text.isEmpty
                    ? null
                    : Text(_folderDescriptionController.text),
                title: _folderNameController.text.isEmpty
                    ? const Text('Nova pasta')
                    : Text(_folderNameController.text),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _folderNameController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Nome da pasta',
              ),
            ),
            TextField(
              controller: _folderDescriptionController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Descrição da pasta (opcional)',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Escollha um ícone personalizado'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _folderIcon = 0;
                        });
                      },
                      icon: FolderIcon(0).icon()),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _folderIcon = 1;
                        });
                      },
                      icon: FolderIcon(1).icon()),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _folderIcon = 3;
                        });
                      },
                      icon: FolderIcon(2).icon()),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _folderIcon = 3;
                        });
                      },
                      icon: FolderIcon(3).icon()),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _folderIcon = 4;
                        });
                      },
                      icon: FolderIcon(4).icon()),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  db.insertFolder(
                    nome: _folderNameController.text,
                    descricao: _folderDescriptionController.text,
                    icon: _folderIcon,
                  );
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.add), Text('Adicionar pasta')],
                ))
          ],
        ),
      ),
    );
  }
}
