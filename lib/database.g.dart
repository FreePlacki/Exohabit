// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HabitTableTable extends HabitTable
    with TableInfo<$HabitTableTable, HabitTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyPerWeekMeta = const VerificationMeta(
    'frequencyPerWeek',
  );
  @override
  late final GeneratedColumn<int> frequencyPerWeek = GeneratedColumn<int>(
    'frequency_per_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    frequencyPerWeek,
    createdAt,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('frequency_per_week')) {
      context.handle(
        _frequencyPerWeekMeta,
        frequencyPerWeek.isAcceptableOrUnknown(
          data['frequency_per_week']!,
          _frequencyPerWeekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frequencyPerWeekMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      frequencyPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency_per_week'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $HabitTableTable createAlias(String alias) {
    return $HabitTableTable(attachedDatabase, alias);
  }
}

class HabitTableData extends DataClass implements Insertable<HabitTableData> {
  final String id;
  final String title;
  final String description;
  final int frequencyPerWeek;
  final DateTime createdAt;
  final bool synced;
  const HabitTableData({
    required this.id,
    required this.title,
    required this.description,
    required this.frequencyPerWeek,
    required this.createdAt,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['frequency_per_week'] = Variable<int>(frequencyPerWeek);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  HabitTableCompanion toCompanion(bool nullToAbsent) {
    return HabitTableCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      frequencyPerWeek: Value(frequencyPerWeek),
      createdAt: Value(createdAt),
      synced: Value(synced),
    );
  }

  factory HabitTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      frequencyPerWeek: serializer.fromJson<int>(json['frequencyPerWeek']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'frequencyPerWeek': serializer.toJson<int>(frequencyPerWeek),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  HabitTableData copyWith({
    String? id,
    String? title,
    String? description,
    int? frequencyPerWeek,
    DateTime? createdAt,
    bool? synced,
  }) => HabitTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    frequencyPerWeek: frequencyPerWeek ?? this.frequencyPerWeek,
    createdAt: createdAt ?? this.createdAt,
    synced: synced ?? this.synced,
  );
  HabitTableData copyWithCompanion(HabitTableCompanion data) {
    return HabitTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      frequencyPerWeek: data.frequencyPerWeek.present
          ? data.frequencyPerWeek.value
          : this.frequencyPerWeek,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('frequencyPerWeek: $frequencyPerWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, frequencyPerWeek, createdAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.frequencyPerWeek == this.frequencyPerWeek &&
          other.createdAt == this.createdAt &&
          other.synced == this.synced);
}

class HabitTableCompanion extends UpdateCompanion<HabitTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> frequencyPerWeek;
  final Value<DateTime> createdAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const HabitTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.frequencyPerWeek = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitTableCompanion.insert({
    required String id,
    required String title,
    required String description,
    required int frequencyPerWeek,
    required DateTime createdAt,
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       frequencyPerWeek = Value(frequencyPerWeek),
       createdAt = Value(createdAt);
  static Insertable<HabitTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? frequencyPerWeek,
    Expression<DateTime>? createdAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (frequencyPerWeek != null) 'frequency_per_week': frequencyPerWeek,
      if (createdAt != null) 'created_at': createdAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<int>? frequencyPerWeek,
    Value<DateTime>? createdAt,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return HabitTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      frequencyPerWeek: frequencyPerWeek ?? this.frequencyPerWeek,
      createdAt: createdAt ?? this.createdAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (frequencyPerWeek.present) {
      map['frequency_per_week'] = Variable<int>(frequencyPerWeek.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('frequencyPerWeek: $frequencyPerWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitTableTable habitTable = $HabitTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habitTable];
}

typedef $$HabitTableTableCreateCompanionBuilder =
    HabitTableCompanion Function({
      required String id,
      required String title,
      required String description,
      required int frequencyPerWeek,
      required DateTime createdAt,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$HabitTableTableUpdateCompanionBuilder =
    HabitTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<int> frequencyPerWeek,
      Value<DateTime> createdAt,
      Value<bool> synced,
      Value<int> rowid,
    });

class $$HabitTableTableFilterComposer
    extends Composer<_$AppDatabase, $HabitTableTable> {
  $$HabitTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequencyPerWeek => $composableBuilder(
    column: $table.frequencyPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitTableTable> {
  $$HabitTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequencyPerWeek => $composableBuilder(
    column: $table.frequencyPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitTableTable> {
  $$HabitTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get frequencyPerWeek => $composableBuilder(
    column: $table.frequencyPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$HabitTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitTableTable,
          HabitTableData,
          $$HabitTableTableFilterComposer,
          $$HabitTableTableOrderingComposer,
          $$HabitTableTableAnnotationComposer,
          $$HabitTableTableCreateCompanionBuilder,
          $$HabitTableTableUpdateCompanionBuilder,
          (
            HabitTableData,
            BaseReferences<_$AppDatabase, $HabitTableTable, HabitTableData>,
          ),
          HabitTableData,
          PrefetchHooks Function()
        > {
  $$HabitTableTableTableManager(_$AppDatabase db, $HabitTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> frequencyPerWeek = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitTableCompanion(
                id: id,
                title: title,
                description: description,
                frequencyPerWeek: frequencyPerWeek,
                createdAt: createdAt,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required int frequencyPerWeek,
                required DateTime createdAt,
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                frequencyPerWeek: frequencyPerWeek,
                createdAt: createdAt,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitTableTable,
      HabitTableData,
      $$HabitTableTableFilterComposer,
      $$HabitTableTableOrderingComposer,
      $$HabitTableTableAnnotationComposer,
      $$HabitTableTableCreateCompanionBuilder,
      $$HabitTableTableUpdateCompanionBuilder,
      (
        HabitTableData,
        BaseReferences<_$AppDatabase, $HabitTableTable, HabitTableData>,
      ),
      HabitTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitTableTableTableManager get habitTable =>
      $$HabitTableTableTableManager(_db, _db.habitTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(database)
const databaseProvider = DatabaseProvider._();

final class DatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$databaseHash() => r'154e50453fa5dcf7cd1e6a7bc6edd333721452a7';
