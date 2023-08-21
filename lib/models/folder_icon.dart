import 'package:flutter/material.dart';

class FolderIcon {
  final int id;
  double? iconSize;
  FolderIcon(this.id);

  Widget icon() {
    switch (id) {
      case 0:
        return const Icon(
          Icons.folder,
        );
      case 1:
        return const Icon(Icons.menu_book);
      case 2:
        return const Icon(Icons.web);
      case 3:
        return const Icon(Icons.pix);
      case 4:
        return const Icon(Icons.recent_actors);
      default:
        return const Icon(Icons.folder);
    }
  }
}
