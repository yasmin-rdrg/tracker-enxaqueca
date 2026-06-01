import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/enxaqueca.dart';

class DatabaseService {
  static Database? _db;

  Future<Database> get banco async {
    if (_db != null) return _db!;
    _db = await _abrirBanco();
    return _db!;
  }

  Future<Database> _abrirBanco() async {
    final caminho = join(await getDatabasesPath(), 'enxaquecas.db');
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE enxaquecas (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            data        TEXT    NOT NULL,
            intensidade INTEGER NOT NULL,
            gatilho     TEXT    NOT NULL,
            remedio     TEXT    NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> inserir(Enxaqueca enxaqueca) async {
    final db = await banco;
    await db.insert(
      'enxaquecas',
      enxaqueca.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Enxaqueca>> listarTodos() async {
    final db = await banco;
    final List<Map<String, dynamic>> maps = await db.query(
      'enxaquecas',
      orderBy: 'data DESC',
    );
    return maps.map((map) => Enxaqueca.fromMap(map)).toList();
  }

  Future<void> apagar(int id) async {
    final db = await banco;
    await db.delete('enxaquecas', where: 'id = ?', whereArgs: [id]);
  }
}