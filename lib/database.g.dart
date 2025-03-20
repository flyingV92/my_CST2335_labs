// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ToDoDataBaseBuilderContract {
  /// Adds migrations to the builder.
  $ToDoDataBaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ToDoDataBaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ToDoDataBase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorToDoDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ToDoDataBaseBuilderContract databaseBuilder(String name) =>
      _$ToDoDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ToDoDataBaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ToDoDataBaseBuilder(null);
}

class _$ToDoDataBaseBuilder implements $ToDoDataBaseBuilderContract {
  _$ToDoDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ToDoDataBaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ToDoDataBaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ToDoDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ToDoDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ToDoDataBase extends ToDoDataBase {
  _$ToDoDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ToDoItemDao? _toDoItemDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ToDoDb` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `toDoName` TEXT NOT NULL, `toDoDeets` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ToDoItemDao get toDoItemDao {
    return _toDoItemDaoInstance ??= _$ToDoItemDao(database, changeListener);
  }
}

class _$ToDoItemDao extends ToDoItemDao {
  _$ToDoItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _toDoDbInsertionAdapter = InsertionAdapter(
            database,
            'ToDoDb',
            (ToDoDb item) => <String, Object?>{
                  'id': item.id,
                  'toDoName': item.toDoName,
                  'toDoDeets': item.toDoDeets
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDoDb> _toDoDbInsertionAdapter;

  @override
  Future<List<ToDoDb>> findAllToDos() async {
    return _queryAdapter.queryList('SELECT * FROM ToDoDB',
        mapper: (Map<String, Object?> row) => ToDoDb(row['id'] as int?,
            row['toDoName'] as String, row['toDoDeets'] as String));
  }

  @override
  Future<void> delete(String toDoName) async {
    await _queryAdapter.queryNoReturn('DELETE FROM ToDoDB WHERE toDoName = ?1',
        arguments: [toDoName]);
  }

  @override
  Future<void> insertToDoItem(ToDoDb toDoDb) async {
    await _toDoDbInsertionAdapter.insert(toDoDb, OnConflictStrategy.abort);
  }
}
