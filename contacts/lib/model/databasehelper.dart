import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:contacts/model/Contact.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contacts.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE Contact(id INTEGER PRIMARY KEY, nome TEXT, email TEXT, phone INTEGER, birthdate TEXT, picture TEXT)'
    );
  }

  Future<int> saveContact(Contact contact) async {
    var dbClient = await db;
    var result = await dbClient.insert('Contact', contact.toMap());
    return result;
  }

  Future<List<Contact>> getContacts() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('Contact');
    List<Contact> contacts = [];
    for (var map in maps) {
      contacts.add(Contact.fromMap(map));
    }
    return contacts;
  }

}
