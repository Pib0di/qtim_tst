// /data/database/app_database.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CartItems extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text()();
  TextColumn get product => text()();
  IntColumn get quantity => integer()();
  TextColumn get variant => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = p.join(directory.path, 'app.db');
    final file = File(path);
    if (!await file.exists()) {
      await file.create();
    }
    return NativeDatabase(file);
  });
}
