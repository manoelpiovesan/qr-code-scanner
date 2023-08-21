import 'package:sqflite/sqflite.dart' as sql;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class DatabaseUtil {
  Future<void> _onCreate(sql.Database db, int version) async {
    print('Criando database Example App!');

    await db.execute('''CREATE TABLE
        folder (
        id INTEGER PRIMARY KEY,
        nome TEXT,
        descricao TEXT,
        icon INTEGER,
        date TEXT
        )''');

    await db.execute('''CREATE TABLE
        qrcodes (
        id INTEGER PRIMARY KEY, 
        valor TEXT,
        folderId INTEGER,
        descricao TEXT, 
        isFavorito INTEGER,
        date TEXT,
        FOREIGN KEY (folderId) REFERENCES folder(id)
        )''');
  }

  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'exampleapp2.db'),
      onCreate: _onCreate,
      version: 2,
    );
  }

  // deletar pasta
  Future<void> deleteFolder(int id) async {
    final db = await database();

    await db.delete(
      'folder',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // resgatar nome da pasta por id
  Future<String> getFolderNameById(int id) async {
    final db = await database();

    final result = await db.query(
      'folder',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.first['nome'].toString();
  }

  /// Inserir pasta
  Future<void> insertFolder({
    required String nome,
    String? descricao,
    int? icon,
  }) async {
    final db = await database();

    print('Inserindo pasta no database!');

    await db.insert(
      'folder',
      {
        'nome': nome,
        'descricao': descricao,
        'icon': icon ?? 0,
        'date': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  /// Resgatar qr codes por id da pasta
  Future<List<Map<String, dynamic>>> getQRCodesByFolderId(int id) async {
    final db = await database();

    final result = await db.query(
      'qrcodes',
      where: 'folderId = ?',
      whereArgs: [id],
    );

    return result;
  }

  /// update folderId do qr code
  Future<void> updateFolderId({
    required int id,
    required int folderId,
  }) async {
    final db = await database();

    await db.update(
      'qrcodes',
      {
        'folderId': folderId,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Resgatar Pastas
  Future<List<Map<String, dynamic>>> getFolders() async {
    final db = await database();

    final result = await db.query('folder');

    return result;
  }

  /// Inserir QRCODE
  Future<void> insertQRCode({
    required String valor,
    String? descricao,
  }) async {
    final db = await database();

    print('Inserindo qr code no database!');

    await db.insert(
      'qrcodes',
      {
        'valor': valor,
        'descricao': descricao,
        'isFavorito': 0, // 0 = false, 1 = true
        'date': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // editar qr code
  Future<void> editQRCode({
    required int id,
    required String valor,
    String descricao = '',
  }) async {
    final db = await database();

    await db.update(
      'qrcodes',
      {
        'valor': valor,
        'descricao': descricao,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // favoritar qr code
  Future<void> toggleFavorite(int id) async {
    final db = await database();

    final qrCode = await getQRCodeById(id);

    await db.update(
      'qrcodes',
      {
        'isFavorito': qrCode['isFavorito'] == 0 ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // resgatar todos os qrcodes
  Future<List<Map<String, dynamic>>> getQRCodes() async {
    final db = await database();

    final result = await db.query('qrcodes');

    return result;
  }

  // resgatar numero de qrcodes
  Future<int> getQRCodeCount() async {
    final db = await database();

    final result = await db.query('qrcodes');

    return result.length;
  }

  // resgatar qr code com id
  Future<Map<String, dynamic>> getQRCodeById(int id) async {
    final db = await database();

    final result = await db.query(
      'qrcodes',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.first;
  }

  // resgatar qrcodes favoritos
  Future<List<Map<String, dynamic>>> getFavoriteQRCodes() async {
    final db = await database();

    final result = await db.query(
      'qrcodes',
      where: 'isFavorito = ?',
      whereArgs: [1],
    );

    return result;
  }

  // deletar qrcode
  Future<void> deleteQRCode(int id) async {
    final db = await database();

    await db.delete(
      'qrcodes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
