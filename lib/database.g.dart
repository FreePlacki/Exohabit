// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HabitCategory, int> category =
      GeneratedColumn<int>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<HabitCategory>($HabitsTable.$convertercategory);
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _hasBeenSyncedMeta = const VerificationMeta(
    'hasBeenSynced',
  );
  @override
  late final GeneratedColumn<bool> hasBeenSynced = GeneratedColumn<bool>(
    'has_been_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_been_synced" IN (0, 1))',
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
    updatedAt,
    category,
    deleted,
    synced,
    hasBeenSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('has_been_synced')) {
      context.handle(
        _hasBeenSyncedMeta,
        hasBeenSynced.isAcceptableOrUnknown(
          data['has_been_synced']!,
          _hasBeenSyncedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
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
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      category: $HabitsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}category'],
        )!,
      ),
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      hasBeenSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_been_synced'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HabitCategory, int, int> $convertercategory =
      const EnumIndexConverter<HabitCategory>(HabitCategory.values);
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final String id;
  final String title;
  final String description;
  final int frequencyPerWeek;
  final DateTime createdAt;
  final DateTime updatedAt;
  final HabitCategory category;
  final bool deleted;
  final bool synced;
  final bool hasBeenSynced;
  const HabitRow({
    required this.id,
    required this.title,
    required this.description,
    required this.frequencyPerWeek,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.deleted,
    required this.synced,
    required this.hasBeenSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['frequency_per_week'] = Variable<int>(frequencyPerWeek);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    {
      map['category'] = Variable<int>(
        $HabitsTable.$convertercategory.toSql(category),
      );
    }
    map['deleted'] = Variable<bool>(deleted);
    map['synced'] = Variable<bool>(synced);
    map['has_been_synced'] = Variable<bool>(hasBeenSynced);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      frequencyPerWeek: Value(frequencyPerWeek),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      category: Value(category),
      deleted: Value(deleted),
      synced: Value(synced),
      hasBeenSynced: Value(hasBeenSynced),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      frequencyPerWeek: serializer.fromJson<int>(json['frequencyPerWeek']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      category: $HabitsTable.$convertercategory.fromJson(
        serializer.fromJson<int>(json['category']),
      ),
      deleted: serializer.fromJson<bool>(json['deleted']),
      synced: serializer.fromJson<bool>(json['synced']),
      hasBeenSynced: serializer.fromJson<bool>(json['hasBeenSynced']),
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
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'category': serializer.toJson<int>(
        $HabitsTable.$convertercategory.toJson(category),
      ),
      'deleted': serializer.toJson<bool>(deleted),
      'synced': serializer.toJson<bool>(synced),
      'hasBeenSynced': serializer.toJson<bool>(hasBeenSynced),
    };
  }

  HabitRow copyWith({
    String? id,
    String? title,
    String? description,
    int? frequencyPerWeek,
    DateTime? createdAt,
    DateTime? updatedAt,
    HabitCategory? category,
    bool? deleted,
    bool? synced,
    bool? hasBeenSynced,
  }) => HabitRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    frequencyPerWeek: frequencyPerWeek ?? this.frequencyPerWeek,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    category: category ?? this.category,
    deleted: deleted ?? this.deleted,
    synced: synced ?? this.synced,
    hasBeenSynced: hasBeenSynced ?? this.hasBeenSynced,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      frequencyPerWeek: data.frequencyPerWeek.present
          ? data.frequencyPerWeek.value
          : this.frequencyPerWeek,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      category: data.category.present ? data.category.value : this.category,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      synced: data.synced.present ? data.synced.value : this.synced,
      hasBeenSynced: data.hasBeenSynced.present
          ? data.hasBeenSynced.value
          : this.hasBeenSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('frequencyPerWeek: $frequencyPerWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('category: $category, ')
          ..write('deleted: $deleted, ')
          ..write('synced: $synced, ')
          ..write('hasBeenSynced: $hasBeenSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    frequencyPerWeek,
    createdAt,
    updatedAt,
    category,
    deleted,
    synced,
    hasBeenSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.frequencyPerWeek == this.frequencyPerWeek &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.category == this.category &&
          other.deleted == this.deleted &&
          other.synced == this.synced &&
          other.hasBeenSynced == this.hasBeenSynced);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> frequencyPerWeek;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<HabitCategory> category;
  final Value<bool> deleted;
  final Value<bool> synced;
  final Value<bool> hasBeenSynced;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.frequencyPerWeek = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.category = const Value.absent(),
    this.deleted = const Value.absent(),
    this.synced = const Value.absent(),
    this.hasBeenSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required int frequencyPerWeek,
    required DateTime createdAt,
    required DateTime updatedAt,
    required HabitCategory category,
    this.deleted = const Value.absent(),
    this.synced = const Value.absent(),
    this.hasBeenSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       frequencyPerWeek = Value(frequencyPerWeek),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       category = Value(category);
  static Insertable<HabitRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? frequencyPerWeek,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? category,
    Expression<bool>? deleted,
    Expression<bool>? synced,
    Expression<bool>? hasBeenSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (frequencyPerWeek != null) 'frequency_per_week': frequencyPerWeek,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (category != null) 'category': category,
      if (deleted != null) 'deleted': deleted,
      if (synced != null) 'synced': synced,
      if (hasBeenSynced != null) 'has_been_synced': hasBeenSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<int>? frequencyPerWeek,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<HabitCategory>? category,
    Value<bool>? deleted,
    Value<bool>? synced,
    Value<bool>? hasBeenSynced,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      frequencyPerWeek: frequencyPerWeek ?? this.frequencyPerWeek,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      deleted: deleted ?? this.deleted,
      synced: synced ?? this.synced,
      hasBeenSynced: hasBeenSynced ?? this.hasBeenSynced,
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
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
        $HabitsTable.$convertercategory.toSql(category.value),
      );
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (hasBeenSynced.present) {
      map['has_been_synced'] = Variable<bool>(hasBeenSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('frequencyPerWeek: $frequencyPerWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('category: $category, ')
          ..write('deleted: $deleted, ')
          ..write('synced: $synced, ')
          ..write('hasBeenSynced: $hasBeenSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompletionsTable extends Completions
    with TableInfo<$CompletionsTable, CompletionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    habitId,
    completedAt,
    updatedAt,
    deleted,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
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
  CompletionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $CompletionsTable createAlias(String alias) {
    return $CompletionsTable(attachedDatabase, alias);
  }
}

class CompletionRow extends DataClass implements Insertable<CompletionRow> {
  final String id;
  final String habitId;
  final DateTime completedAt;
  final DateTime updatedAt;
  final bool deleted;
  final bool synced;
  const CompletionRow({
    required this.id,
    required this.habitId,
    required this.completedAt,
    required this.updatedAt,
    required this.deleted,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  CompletionsCompanion toCompanion(bool nullToAbsent) {
    return CompletionsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      completedAt: Value(completedAt),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      synced: Value(synced),
    );
  }

  factory CompletionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletionRow(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  CompletionRow copyWith({
    String? id,
    String? habitId,
    DateTime? completedAt,
    DateTime? updatedAt,
    bool? deleted,
    bool? synced,
  }) => CompletionRow(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    completedAt: completedAt ?? this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    synced: synced ?? this.synced,
  );
  CompletionRow copyWithCompanion(CompletionsCompanion data) {
    return CompletionRow(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletionRow(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, completedAt, updatedAt, deleted, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletionRow &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.synced == this.synced);
}

class CompletionsCompanion extends UpdateCompanion<CompletionRow> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> completedAt;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> synced;
  final Value<int> rowid;
  const CompletionsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompletionsCompanion.insert({
    required String id,
    required String habitId,
    required DateTime completedAt,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       completedAt = Value(completedAt),
       updatedAt = Value(updatedAt);
  static Insertable<CompletionRow> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompletionsCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? completedAt,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return CompletionsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
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
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
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
    return (StringBuffer('CompletionsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExoplanetsTable extends Exoplanets
    with TableInfo<$ExoplanetsTable, Exoplanet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExoplanetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hostNameMeta = const VerificationMeta(
    'hostName',
  );
  @override
  late final GeneratedColumn<String> hostName = GeneratedColumn<String>(
    'host_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discYearMeta = const VerificationMeta(
    'discYear',
  );
  @override
  late final GeneratedColumn<int> discYear = GeneratedColumn<int>(
    'disc_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orbitalPeriodMeta = const VerificationMeta(
    'orbitalPeriod',
  );
  @override
  late final GeneratedColumn<double> orbitalPeriod = GeneratedColumn<double>(
    'orbital_period',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _radiusMeta = const VerificationMeta('radius');
  @override
  late final GeneratedColumn<double> radius = GeneratedColumn<double>(
    'radius',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _massMeta = const VerificationMeta('mass');
  @override
  late final GeneratedColumn<double> mass = GeneratedColumn<double>(
    'mass',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syDistanceMeta = const VerificationMeta(
    'syDistance',
  );
  @override
  late final GeneratedColumn<double> syDistance = GeneratedColumn<double>(
    'sy_distance',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discoveryMethodMeta = const VerificationMeta(
    'discoveryMethod',
  );
  @override
  late final GeneratedColumn<String> discoveryMethod = GeneratedColumn<String>(
    'discovery_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stSpectypeMeta = const VerificationMeta(
    'stSpectype',
  );
  @override
  late final GeneratedColumn<String> stSpectype = GeneratedColumn<String>(
    'st_spectype',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    name,
    hostName,
    discYear,
    orbitalPeriod,
    radius,
    mass,
    temperature,
    syDistance,
    discoveryMethod,
    stSpectype,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exoplanets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exoplanet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('host_name')) {
      context.handle(
        _hostNameMeta,
        hostName.isAcceptableOrUnknown(data['host_name']!, _hostNameMeta),
      );
    }
    if (data.containsKey('disc_year')) {
      context.handle(
        _discYearMeta,
        discYear.isAcceptableOrUnknown(data['disc_year']!, _discYearMeta),
      );
    }
    if (data.containsKey('orbital_period')) {
      context.handle(
        _orbitalPeriodMeta,
        orbitalPeriod.isAcceptableOrUnknown(
          data['orbital_period']!,
          _orbitalPeriodMeta,
        ),
      );
    }
    if (data.containsKey('radius')) {
      context.handle(
        _radiusMeta,
        radius.isAcceptableOrUnknown(data['radius']!, _radiusMeta),
      );
    }
    if (data.containsKey('mass')) {
      context.handle(
        _massMeta,
        mass.isAcceptableOrUnknown(data['mass']!, _massMeta),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('sy_distance')) {
      context.handle(
        _syDistanceMeta,
        syDistance.isAcceptableOrUnknown(data['sy_distance']!, _syDistanceMeta),
      );
    }
    if (data.containsKey('discovery_method')) {
      context.handle(
        _discoveryMethodMeta,
        discoveryMethod.isAcceptableOrUnknown(
          data['discovery_method']!,
          _discoveryMethodMeta,
        ),
      );
    }
    if (data.containsKey('st_spectype')) {
      context.handle(
        _stSpectypeMeta,
        stSpectype.isAcceptableOrUnknown(data['st_spectype']!, _stSpectypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Exoplanet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exoplanet(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hostName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}host_name'],
      ),
      discYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disc_year'],
      ),
      orbitalPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}orbital_period'],
      ),
      radius: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}radius'],
      ),
      mass: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mass'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      syDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sy_distance'],
      ),
      discoveryMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discovery_method'],
      ),
      stSpectype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}st_spectype'],
      ),
    );
  }

  @override
  $ExoplanetsTable createAlias(String alias) {
    return $ExoplanetsTable(attachedDatabase, alias);
  }
}

class Exoplanet extends DataClass implements Insertable<Exoplanet> {
  final String name;
  final String? hostName;
  final int? discYear;
  final double? orbitalPeriod;
  final double? radius;
  final double? mass;
  final double? temperature;
  final double? syDistance;
  final String? discoveryMethod;
  final String? stSpectype;
  const Exoplanet({
    required this.name,
    this.hostName,
    this.discYear,
    this.orbitalPeriod,
    this.radius,
    this.mass,
    this.temperature,
    this.syDistance,
    this.discoveryMethod,
    this.stSpectype,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || hostName != null) {
      map['host_name'] = Variable<String>(hostName);
    }
    if (!nullToAbsent || discYear != null) {
      map['disc_year'] = Variable<int>(discYear);
    }
    if (!nullToAbsent || orbitalPeriod != null) {
      map['orbital_period'] = Variable<double>(orbitalPeriod);
    }
    if (!nullToAbsent || radius != null) {
      map['radius'] = Variable<double>(radius);
    }
    if (!nullToAbsent || mass != null) {
      map['mass'] = Variable<double>(mass);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || syDistance != null) {
      map['sy_distance'] = Variable<double>(syDistance);
    }
    if (!nullToAbsent || discoveryMethod != null) {
      map['discovery_method'] = Variable<String>(discoveryMethod);
    }
    if (!nullToAbsent || stSpectype != null) {
      map['st_spectype'] = Variable<String>(stSpectype);
    }
    return map;
  }

  ExoplanetsCompanion toCompanion(bool nullToAbsent) {
    return ExoplanetsCompanion(
      name: Value(name),
      hostName: hostName == null && nullToAbsent
          ? const Value.absent()
          : Value(hostName),
      discYear: discYear == null && nullToAbsent
          ? const Value.absent()
          : Value(discYear),
      orbitalPeriod: orbitalPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(orbitalPeriod),
      radius: radius == null && nullToAbsent
          ? const Value.absent()
          : Value(radius),
      mass: mass == null && nullToAbsent ? const Value.absent() : Value(mass),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      syDistance: syDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(syDistance),
      discoveryMethod: discoveryMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(discoveryMethod),
      stSpectype: stSpectype == null && nullToAbsent
          ? const Value.absent()
          : Value(stSpectype),
    );
  }

  factory Exoplanet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exoplanet(
      name: serializer.fromJson<String>(json['name']),
      hostName: serializer.fromJson<String?>(json['hostName']),
      discYear: serializer.fromJson<int?>(json['discYear']),
      orbitalPeriod: serializer.fromJson<double?>(json['orbitalPeriod']),
      radius: serializer.fromJson<double?>(json['radius']),
      mass: serializer.fromJson<double?>(json['mass']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      syDistance: serializer.fromJson<double?>(json['syDistance']),
      discoveryMethod: serializer.fromJson<String?>(json['discoveryMethod']),
      stSpectype: serializer.fromJson<String?>(json['stSpectype']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'hostName': serializer.toJson<String?>(hostName),
      'discYear': serializer.toJson<int?>(discYear),
      'orbitalPeriod': serializer.toJson<double?>(orbitalPeriod),
      'radius': serializer.toJson<double?>(radius),
      'mass': serializer.toJson<double?>(mass),
      'temperature': serializer.toJson<double?>(temperature),
      'syDistance': serializer.toJson<double?>(syDistance),
      'discoveryMethod': serializer.toJson<String?>(discoveryMethod),
      'stSpectype': serializer.toJson<String?>(stSpectype),
    };
  }

  Exoplanet copyWith({
    String? name,
    Value<String?> hostName = const Value.absent(),
    Value<int?> discYear = const Value.absent(),
    Value<double?> orbitalPeriod = const Value.absent(),
    Value<double?> radius = const Value.absent(),
    Value<double?> mass = const Value.absent(),
    Value<double?> temperature = const Value.absent(),
    Value<double?> syDistance = const Value.absent(),
    Value<String?> discoveryMethod = const Value.absent(),
    Value<String?> stSpectype = const Value.absent(),
  }) => Exoplanet(
    name: name ?? this.name,
    hostName: hostName.present ? hostName.value : this.hostName,
    discYear: discYear.present ? discYear.value : this.discYear,
    orbitalPeriod: orbitalPeriod.present
        ? orbitalPeriod.value
        : this.orbitalPeriod,
    radius: radius.present ? radius.value : this.radius,
    mass: mass.present ? mass.value : this.mass,
    temperature: temperature.present ? temperature.value : this.temperature,
    syDistance: syDistance.present ? syDistance.value : this.syDistance,
    discoveryMethod: discoveryMethod.present
        ? discoveryMethod.value
        : this.discoveryMethod,
    stSpectype: stSpectype.present ? stSpectype.value : this.stSpectype,
  );
  Exoplanet copyWithCompanion(ExoplanetsCompanion data) {
    return Exoplanet(
      name: data.name.present ? data.name.value : this.name,
      hostName: data.hostName.present ? data.hostName.value : this.hostName,
      discYear: data.discYear.present ? data.discYear.value : this.discYear,
      orbitalPeriod: data.orbitalPeriod.present
          ? data.orbitalPeriod.value
          : this.orbitalPeriod,
      radius: data.radius.present ? data.radius.value : this.radius,
      mass: data.mass.present ? data.mass.value : this.mass,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      syDistance: data.syDistance.present
          ? data.syDistance.value
          : this.syDistance,
      discoveryMethod: data.discoveryMethod.present
          ? data.discoveryMethod.value
          : this.discoveryMethod,
      stSpectype: data.stSpectype.present
          ? data.stSpectype.value
          : this.stSpectype,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exoplanet(')
          ..write('name: $name, ')
          ..write('hostName: $hostName, ')
          ..write('discYear: $discYear, ')
          ..write('orbitalPeriod: $orbitalPeriod, ')
          ..write('radius: $radius, ')
          ..write('mass: $mass, ')
          ..write('temperature: $temperature, ')
          ..write('syDistance: $syDistance, ')
          ..write('discoveryMethod: $discoveryMethod, ')
          ..write('stSpectype: $stSpectype')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    name,
    hostName,
    discYear,
    orbitalPeriod,
    radius,
    mass,
    temperature,
    syDistance,
    discoveryMethod,
    stSpectype,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exoplanet &&
          other.name == this.name &&
          other.hostName == this.hostName &&
          other.discYear == this.discYear &&
          other.orbitalPeriod == this.orbitalPeriod &&
          other.radius == this.radius &&
          other.mass == this.mass &&
          other.temperature == this.temperature &&
          other.syDistance == this.syDistance &&
          other.discoveryMethod == this.discoveryMethod &&
          other.stSpectype == this.stSpectype);
}

class ExoplanetsCompanion extends UpdateCompanion<Exoplanet> {
  final Value<String> name;
  final Value<String?> hostName;
  final Value<int?> discYear;
  final Value<double?> orbitalPeriod;
  final Value<double?> radius;
  final Value<double?> mass;
  final Value<double?> temperature;
  final Value<double?> syDistance;
  final Value<String?> discoveryMethod;
  final Value<String?> stSpectype;
  final Value<int> rowid;
  const ExoplanetsCompanion({
    this.name = const Value.absent(),
    this.hostName = const Value.absent(),
    this.discYear = const Value.absent(),
    this.orbitalPeriod = const Value.absent(),
    this.radius = const Value.absent(),
    this.mass = const Value.absent(),
    this.temperature = const Value.absent(),
    this.syDistance = const Value.absent(),
    this.discoveryMethod = const Value.absent(),
    this.stSpectype = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExoplanetsCompanion.insert({
    required String name,
    this.hostName = const Value.absent(),
    this.discYear = const Value.absent(),
    this.orbitalPeriod = const Value.absent(),
    this.radius = const Value.absent(),
    this.mass = const Value.absent(),
    this.temperature = const Value.absent(),
    this.syDistance = const Value.absent(),
    this.discoveryMethod = const Value.absent(),
    this.stSpectype = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Exoplanet> custom({
    Expression<String>? name,
    Expression<String>? hostName,
    Expression<int>? discYear,
    Expression<double>? orbitalPeriod,
    Expression<double>? radius,
    Expression<double>? mass,
    Expression<double>? temperature,
    Expression<double>? syDistance,
    Expression<String>? discoveryMethod,
    Expression<String>? stSpectype,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (hostName != null) 'host_name': hostName,
      if (discYear != null) 'disc_year': discYear,
      if (orbitalPeriod != null) 'orbital_period': orbitalPeriod,
      if (radius != null) 'radius': radius,
      if (mass != null) 'mass': mass,
      if (temperature != null) 'temperature': temperature,
      if (syDistance != null) 'sy_distance': syDistance,
      if (discoveryMethod != null) 'discovery_method': discoveryMethod,
      if (stSpectype != null) 'st_spectype': stSpectype,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExoplanetsCompanion copyWith({
    Value<String>? name,
    Value<String?>? hostName,
    Value<int?>? discYear,
    Value<double?>? orbitalPeriod,
    Value<double?>? radius,
    Value<double?>? mass,
    Value<double?>? temperature,
    Value<double?>? syDistance,
    Value<String?>? discoveryMethod,
    Value<String?>? stSpectype,
    Value<int>? rowid,
  }) {
    return ExoplanetsCompanion(
      name: name ?? this.name,
      hostName: hostName ?? this.hostName,
      discYear: discYear ?? this.discYear,
      orbitalPeriod: orbitalPeriod ?? this.orbitalPeriod,
      radius: radius ?? this.radius,
      mass: mass ?? this.mass,
      temperature: temperature ?? this.temperature,
      syDistance: syDistance ?? this.syDistance,
      discoveryMethod: discoveryMethod ?? this.discoveryMethod,
      stSpectype: stSpectype ?? this.stSpectype,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hostName.present) {
      map['host_name'] = Variable<String>(hostName.value);
    }
    if (discYear.present) {
      map['disc_year'] = Variable<int>(discYear.value);
    }
    if (orbitalPeriod.present) {
      map['orbital_period'] = Variable<double>(orbitalPeriod.value);
    }
    if (radius.present) {
      map['radius'] = Variable<double>(radius.value);
    }
    if (mass.present) {
      map['mass'] = Variable<double>(mass.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (syDistance.present) {
      map['sy_distance'] = Variable<double>(syDistance.value);
    }
    if (discoveryMethod.present) {
      map['discovery_method'] = Variable<String>(discoveryMethod.value);
    }
    if (stSpectype.present) {
      map['st_spectype'] = Variable<String>(stSpectype.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExoplanetsCompanion(')
          ..write('name: $name, ')
          ..write('hostName: $hostName, ')
          ..write('discYear: $discYear, ')
          ..write('orbitalPeriod: $orbitalPeriod, ')
          ..write('radius: $radius, ')
          ..write('mass: $mass, ')
          ..write('temperature: $temperature, ')
          ..write('syDistance: $syDistance, ')
          ..write('discoveryMethod: $discoveryMethod, ')
          ..write('stSpectype: $stSpectype, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RewardsTable extends Rewards with TableInfo<$RewardsTable, RewardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exoplanetNameMeta = const VerificationMeta(
    'exoplanetName',
  );
  @override
  late final GeneratedColumn<String> exoplanetName = GeneratedColumn<String>(
    'exoplanet_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exoplanets (name)',
    ),
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
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    exoplanetName,
    createdAt,
    deleted,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rewards';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exoplanet_name')) {
      context.handle(
        _exoplanetNameMeta,
        exoplanetName.isAcceptableOrUnknown(
          data['exoplanet_name']!,
          _exoplanetNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exoplanetNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
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
  Set<GeneratedColumn> get $primaryKey => {exoplanetName};
  @override
  RewardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardRow(
      exoplanetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exoplanet_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $RewardsTable createAlias(String alias) {
    return $RewardsTable(attachedDatabase, alias);
  }
}

class RewardRow extends DataClass implements Insertable<RewardRow> {
  final String exoplanetName;
  final DateTime createdAt;
  final bool deleted;
  final bool synced;
  const RewardRow({
    required this.exoplanetName,
    required this.createdAt,
    required this.deleted,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exoplanet_name'] = Variable<String>(exoplanetName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['deleted'] = Variable<bool>(deleted);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  RewardsCompanion toCompanion(bool nullToAbsent) {
    return RewardsCompanion(
      exoplanetName: Value(exoplanetName),
      createdAt: Value(createdAt),
      deleted: Value(deleted),
      synced: Value(synced),
    );
  }

  factory RewardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardRow(
      exoplanetName: serializer.fromJson<String>(json['exoplanetName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exoplanetName': serializer.toJson<String>(exoplanetName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deleted': serializer.toJson<bool>(deleted),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  RewardRow copyWith({
    String? exoplanetName,
    DateTime? createdAt,
    bool? deleted,
    bool? synced,
  }) => RewardRow(
    exoplanetName: exoplanetName ?? this.exoplanetName,
    createdAt: createdAt ?? this.createdAt,
    deleted: deleted ?? this.deleted,
    synced: synced ?? this.synced,
  );
  RewardRow copyWithCompanion(RewardsCompanion data) {
    return RewardRow(
      exoplanetName: data.exoplanetName.present
          ? data.exoplanetName.value
          : this.exoplanetName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardRow(')
          ..write('exoplanetName: $exoplanetName, ')
          ..write('createdAt: $createdAt, ')
          ..write('deleted: $deleted, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(exoplanetName, createdAt, deleted, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardRow &&
          other.exoplanetName == this.exoplanetName &&
          other.createdAt == this.createdAt &&
          other.deleted == this.deleted &&
          other.synced == this.synced);
}

class RewardsCompanion extends UpdateCompanion<RewardRow> {
  final Value<String> exoplanetName;
  final Value<DateTime> createdAt;
  final Value<bool> deleted;
  final Value<bool> synced;
  final Value<int> rowid;
  const RewardsCompanion({
    this.exoplanetName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RewardsCompanion.insert({
    required String exoplanetName,
    required DateTime createdAt,
    this.deleted = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : exoplanetName = Value(exoplanetName),
       createdAt = Value(createdAt);
  static Insertable<RewardRow> custom({
    Expression<String>? exoplanetName,
    Expression<DateTime>? createdAt,
    Expression<bool>? deleted,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exoplanetName != null) 'exoplanet_name': exoplanetName,
      if (createdAt != null) 'created_at': createdAt,
      if (deleted != null) 'deleted': deleted,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RewardsCompanion copyWith({
    Value<String>? exoplanetName,
    Value<DateTime>? createdAt,
    Value<bool>? deleted,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return RewardsCompanion(
      exoplanetName: exoplanetName ?? this.exoplanetName,
      createdAt: createdAt ?? this.createdAt,
      deleted: deleted ?? this.deleted,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exoplanetName.present) {
      map['exoplanet_name'] = Variable<String>(exoplanetName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
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
    return (StringBuffer('RewardsCompanion(')
          ..write('exoplanetName: $exoplanetName, ')
          ..write('createdAt: $createdAt, ')
          ..write('deleted: $deleted, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $CompletionsTable completions = $CompletionsTable(this);
  late final $ExoplanetsTable exoplanets = $ExoplanetsTable(this);
  late final $RewardsTable rewards = $RewardsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    completions,
    exoplanets,
    rewards,
  ];
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      required String title,
      required String description,
      required int frequencyPerWeek,
      required DateTime createdAt,
      required DateTime updatedAt,
      required HabitCategory category,
      Value<bool> deleted,
      Value<bool> synced,
      Value<bool> hasBeenSynced,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<int> frequencyPerWeek,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<HabitCategory> category,
      Value<bool> deleted,
      Value<bool> synced,
      Value<bool> hasBeenSynced,
      Value<int> rowid,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, HabitRow> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CompletionsTable, List<CompletionRow>>
  _completionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.completions,
    aliasName: $_aliasNameGenerator(db.habits.id, db.completions.habitId),
  );

  $$CompletionsTableProcessedTableManager get completionsRefs {
    final manager = $$CompletionsTableTableManager(
      $_db,
      $_db.completions,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_completionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
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

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitCategory, HabitCategory, int>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasBeenSynced => $composableBuilder(
    column: $table.hasBeenSynced,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> completionsRefs(
    Expression<bool> Function($$CompletionsTableFilterComposer f) f,
  ) {
    final $$CompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.completions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompletionsTableFilterComposer(
            $db: $db,
            $table: $db.completions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasBeenSynced => $composableBuilder(
    column: $table.hasBeenSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HabitCategory, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<bool> get hasBeenSynced => $composableBuilder(
    column: $table.hasBeenSynced,
    builder: (column) => column,
  );

  Expression<T> completionsRefs<T extends Object>(
    Expression<T> Function($$CompletionsTableAnnotationComposer a) f,
  ) {
    final $$CompletionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.completions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompletionsTableAnnotationComposer(
            $db: $db,
            $table: $db.completions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, $$HabitsTableReferences),
          HabitRow,
          PrefetchHooks Function({bool completionsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> frequencyPerWeek = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<HabitCategory> category = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<bool> hasBeenSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                title: title,
                description: description,
                frequencyPerWeek: frequencyPerWeek,
                createdAt: createdAt,
                updatedAt: updatedAt,
                category: category,
                deleted: deleted,
                synced: synced,
                hasBeenSynced: hasBeenSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required int frequencyPerWeek,
                required DateTime createdAt,
                required DateTime updatedAt,
                required HabitCategory category,
                Value<bool> deleted = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<bool> hasBeenSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                title: title,
                description: description,
                frequencyPerWeek: frequencyPerWeek,
                createdAt: createdAt,
                updatedAt: updatedAt,
                category: category,
                deleted: deleted,
                synced: synced,
                hasBeenSynced: hasBeenSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({completionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (completionsRefs) db.completions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (completionsRefs)
                    await $_getPrefetchedData<
                      HabitRow,
                      $HabitsTable,
                      CompletionRow
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._completionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$HabitsTableReferences(
                        db,
                        table,
                        p0,
                      ).completionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, $$HabitsTableReferences),
      HabitRow,
      PrefetchHooks Function({bool completionsRefs})
    >;
typedef $$CompletionsTableCreateCompanionBuilder =
    CompletionsCompanion Function({
      required String id,
      required String habitId,
      required DateTime completedAt,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$CompletionsTableUpdateCompanionBuilder =
    CompletionsCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> completedAt,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> synced,
      Value<int> rowid,
    });

final class $$CompletionsTableReferences
    extends BaseReferences<_$AppDatabase, $CompletionsTable, CompletionRow> {
  $$CompletionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.completions.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $CompletionsTable> {
  $$CompletionsTableFilterComposer({
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

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompletionsTable> {
  $$CompletionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompletionsTable> {
  $$CompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompletionsTable,
          CompletionRow,
          $$CompletionsTableFilterComposer,
          $$CompletionsTableOrderingComposer,
          $$CompletionsTableAnnotationComposer,
          $$CompletionsTableCreateCompanionBuilder,
          $$CompletionsTableUpdateCompanionBuilder,
          (CompletionRow, $$CompletionsTableReferences),
          CompletionRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$CompletionsTableTableManager(_$AppDatabase db, $CompletionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletionsCompanion(
                id: id,
                habitId: habitId,
                completedAt: completedAt,
                updatedAt: updatedAt,
                deleted: deleted,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime completedAt,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletionsCompanion.insert(
                id: id,
                habitId: habitId,
                completedAt: completedAt,
                updatedAt: updatedAt,
                deleted: deleted,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$CompletionsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$CompletionsTableReferences
                                    ._habitIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompletionsTable,
      CompletionRow,
      $$CompletionsTableFilterComposer,
      $$CompletionsTableOrderingComposer,
      $$CompletionsTableAnnotationComposer,
      $$CompletionsTableCreateCompanionBuilder,
      $$CompletionsTableUpdateCompanionBuilder,
      (CompletionRow, $$CompletionsTableReferences),
      CompletionRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$ExoplanetsTableCreateCompanionBuilder =
    ExoplanetsCompanion Function({
      required String name,
      Value<String?> hostName,
      Value<int?> discYear,
      Value<double?> orbitalPeriod,
      Value<double?> radius,
      Value<double?> mass,
      Value<double?> temperature,
      Value<double?> syDistance,
      Value<String?> discoveryMethod,
      Value<String?> stSpectype,
      Value<int> rowid,
    });
typedef $$ExoplanetsTableUpdateCompanionBuilder =
    ExoplanetsCompanion Function({
      Value<String> name,
      Value<String?> hostName,
      Value<int?> discYear,
      Value<double?> orbitalPeriod,
      Value<double?> radius,
      Value<double?> mass,
      Value<double?> temperature,
      Value<double?> syDistance,
      Value<String?> discoveryMethod,
      Value<String?> stSpectype,
      Value<int> rowid,
    });

final class $$ExoplanetsTableReferences
    extends BaseReferences<_$AppDatabase, $ExoplanetsTable, Exoplanet> {
  $$ExoplanetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RewardsTable, List<RewardRow>> _rewardsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.rewards,
    aliasName: $_aliasNameGenerator(
      db.exoplanets.name,
      db.rewards.exoplanetName,
    ),
  );

  $$RewardsTableProcessedTableManager get rewardsRefs {
    final manager = $$RewardsTableTableManager($_db, $_db.rewards).filter(
      (f) => f.exoplanetName.name.sqlEquals($_itemColumn<String>('name')!),
    );

    final cache = $_typedResult.readTableOrNull(_rewardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExoplanetsTableFilterComposer
    extends Composer<_$AppDatabase, $ExoplanetsTable> {
  $$ExoplanetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hostName => $composableBuilder(
    column: $table.hostName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discYear => $composableBuilder(
    column: $table.discYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get orbitalPeriod => $composableBuilder(
    column: $table.orbitalPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get radius => $composableBuilder(
    column: $table.radius,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mass => $composableBuilder(
    column: $table.mass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get syDistance => $composableBuilder(
    column: $table.syDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discoveryMethod => $composableBuilder(
    column: $table.discoveryMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stSpectype => $composableBuilder(
    column: $table.stSpectype,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rewardsRefs(
    Expression<bool> Function($$RewardsTableFilterComposer f) f,
  ) {
    final $$RewardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.name,
      referencedTable: $db.rewards,
      getReferencedColumn: (t) => t.exoplanetName,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RewardsTableFilterComposer(
            $db: $db,
            $table: $db.rewards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExoplanetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExoplanetsTable> {
  $$ExoplanetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hostName => $composableBuilder(
    column: $table.hostName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discYear => $composableBuilder(
    column: $table.discYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get orbitalPeriod => $composableBuilder(
    column: $table.orbitalPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get radius => $composableBuilder(
    column: $table.radius,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mass => $composableBuilder(
    column: $table.mass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get syDistance => $composableBuilder(
    column: $table.syDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discoveryMethod => $composableBuilder(
    column: $table.discoveryMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stSpectype => $composableBuilder(
    column: $table.stSpectype,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExoplanetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExoplanetsTable> {
  $$ExoplanetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get hostName =>
      $composableBuilder(column: $table.hostName, builder: (column) => column);

  GeneratedColumn<int> get discYear =>
      $composableBuilder(column: $table.discYear, builder: (column) => column);

  GeneratedColumn<double> get orbitalPeriod => $composableBuilder(
    column: $table.orbitalPeriod,
    builder: (column) => column,
  );

  GeneratedColumn<double> get radius =>
      $composableBuilder(column: $table.radius, builder: (column) => column);

  GeneratedColumn<double> get mass =>
      $composableBuilder(column: $table.mass, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get syDistance => $composableBuilder(
    column: $table.syDistance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get discoveryMethod => $composableBuilder(
    column: $table.discoveryMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stSpectype => $composableBuilder(
    column: $table.stSpectype,
    builder: (column) => column,
  );

  Expression<T> rewardsRefs<T extends Object>(
    Expression<T> Function($$RewardsTableAnnotationComposer a) f,
  ) {
    final $$RewardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.name,
      referencedTable: $db.rewards,
      getReferencedColumn: (t) => t.exoplanetName,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RewardsTableAnnotationComposer(
            $db: $db,
            $table: $db.rewards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExoplanetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExoplanetsTable,
          Exoplanet,
          $$ExoplanetsTableFilterComposer,
          $$ExoplanetsTableOrderingComposer,
          $$ExoplanetsTableAnnotationComposer,
          $$ExoplanetsTableCreateCompanionBuilder,
          $$ExoplanetsTableUpdateCompanionBuilder,
          (Exoplanet, $$ExoplanetsTableReferences),
          Exoplanet,
          PrefetchHooks Function({bool rewardsRefs})
        > {
  $$ExoplanetsTableTableManager(_$AppDatabase db, $ExoplanetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExoplanetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExoplanetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExoplanetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<String?> hostName = const Value.absent(),
                Value<int?> discYear = const Value.absent(),
                Value<double?> orbitalPeriod = const Value.absent(),
                Value<double?> radius = const Value.absent(),
                Value<double?> mass = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> syDistance = const Value.absent(),
                Value<String?> discoveryMethod = const Value.absent(),
                Value<String?> stSpectype = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExoplanetsCompanion(
                name: name,
                hostName: hostName,
                discYear: discYear,
                orbitalPeriod: orbitalPeriod,
                radius: radius,
                mass: mass,
                temperature: temperature,
                syDistance: syDistance,
                discoveryMethod: discoveryMethod,
                stSpectype: stSpectype,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String name,
                Value<String?> hostName = const Value.absent(),
                Value<int?> discYear = const Value.absent(),
                Value<double?> orbitalPeriod = const Value.absent(),
                Value<double?> radius = const Value.absent(),
                Value<double?> mass = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> syDistance = const Value.absent(),
                Value<String?> discoveryMethod = const Value.absent(),
                Value<String?> stSpectype = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExoplanetsCompanion.insert(
                name: name,
                hostName: hostName,
                discYear: discYear,
                orbitalPeriod: orbitalPeriod,
                radius: radius,
                mass: mass,
                temperature: temperature,
                syDistance: syDistance,
                discoveryMethod: discoveryMethod,
                stSpectype: stSpectype,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExoplanetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rewardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (rewardsRefs) db.rewards],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (rewardsRefs)
                    await $_getPrefetchedData<
                      Exoplanet,
                      $ExoplanetsTable,
                      RewardRow
                    >(
                      currentTable: table,
                      referencedTable: $$ExoplanetsTableReferences
                          ._rewardsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExoplanetsTableReferences(
                            db,
                            table,
                            p0,
                          ).rewardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.exoplanetName == item.name,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExoplanetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExoplanetsTable,
      Exoplanet,
      $$ExoplanetsTableFilterComposer,
      $$ExoplanetsTableOrderingComposer,
      $$ExoplanetsTableAnnotationComposer,
      $$ExoplanetsTableCreateCompanionBuilder,
      $$ExoplanetsTableUpdateCompanionBuilder,
      (Exoplanet, $$ExoplanetsTableReferences),
      Exoplanet,
      PrefetchHooks Function({bool rewardsRefs})
    >;
typedef $$RewardsTableCreateCompanionBuilder =
    RewardsCompanion Function({
      required String exoplanetName,
      required DateTime createdAt,
      Value<bool> deleted,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$RewardsTableUpdateCompanionBuilder =
    RewardsCompanion Function({
      Value<String> exoplanetName,
      Value<DateTime> createdAt,
      Value<bool> deleted,
      Value<bool> synced,
      Value<int> rowid,
    });

final class $$RewardsTableReferences
    extends BaseReferences<_$AppDatabase, $RewardsTable, RewardRow> {
  $$RewardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExoplanetsTable _exoplanetNameTable(_$AppDatabase db) =>
      db.exoplanets.createAlias(
        $_aliasNameGenerator(db.rewards.exoplanetName, db.exoplanets.name),
      );

  $$ExoplanetsTableProcessedTableManager get exoplanetName {
    final $_column = $_itemColumn<String>('exoplanet_name')!;

    final manager = $$ExoplanetsTableTableManager(
      $_db,
      $_db.exoplanets,
    ).filter((f) => f.name.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exoplanetNameTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RewardsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  $$ExoplanetsTableFilterComposer get exoplanetName {
    final $$ExoplanetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exoplanetName,
      referencedTable: $db.exoplanets,
      getReferencedColumn: (t) => t.name,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExoplanetsTableFilterComposer(
            $db: $db,
            $table: $db.exoplanets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RewardsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExoplanetsTableOrderingComposer get exoplanetName {
    final $$ExoplanetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exoplanetName,
      referencedTable: $db.exoplanets,
      getReferencedColumn: (t) => t.name,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExoplanetsTableOrderingComposer(
            $db: $db,
            $table: $db.exoplanets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RewardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  $$ExoplanetsTableAnnotationComposer get exoplanetName {
    final $$ExoplanetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exoplanetName,
      referencedTable: $db.exoplanets,
      getReferencedColumn: (t) => t.name,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExoplanetsTableAnnotationComposer(
            $db: $db,
            $table: $db.exoplanets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RewardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardsTable,
          RewardRow,
          $$RewardsTableFilterComposer,
          $$RewardsTableOrderingComposer,
          $$RewardsTableAnnotationComposer,
          $$RewardsTableCreateCompanionBuilder,
          $$RewardsTableUpdateCompanionBuilder,
          (RewardRow, $$RewardsTableReferences),
          RewardRow,
          PrefetchHooks Function({bool exoplanetName})
        > {
  $$RewardsTableTableManager(_$AppDatabase db, $RewardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exoplanetName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardsCompanion(
                exoplanetName: exoplanetName,
                createdAt: createdAt,
                deleted: deleted,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exoplanetName,
                required DateTime createdAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardsCompanion.insert(
                exoplanetName: exoplanetName,
                createdAt: createdAt,
                deleted: deleted,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RewardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exoplanetName = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exoplanetName) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exoplanetName,
                                referencedTable: $$RewardsTableReferences
                                    ._exoplanetNameTable(db),
                                referencedColumn: $$RewardsTableReferences
                                    ._exoplanetNameTable(db)
                                    .name,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RewardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardsTable,
      RewardRow,
      $$RewardsTableFilterComposer,
      $$RewardsTableOrderingComposer,
      $$RewardsTableAnnotationComposer,
      $$RewardsTableCreateCompanionBuilder,
      $$RewardsTableUpdateCompanionBuilder,
      (RewardRow, $$RewardsTableReferences),
      RewardRow,
      PrefetchHooks Function({bool exoplanetName})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$CompletionsTableTableManager get completions =>
      $$CompletionsTableTableManager(_db, _db.completions);
  $$ExoplanetsTableTableManager get exoplanets =>
      $$ExoplanetsTableTableManager(_db, _db.exoplanets);
  $$RewardsTableTableManager get rewards =>
      $$RewardsTableTableManager(_db, _db.rewards);
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
        isAutoDispose: false,
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

String _$databaseHash() => r'd6e05638b723b0524e474cecb5226cbaac2e507a';
