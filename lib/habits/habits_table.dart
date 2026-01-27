import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/sync/sync_service.dart';
import 'package:flutter/material.dart' show Color, Colors, IconData, Icons;

class Habit implements SyncEntity {
  Habit(this.row);
  final HabitRow row;

  @override
  String get id => row.id;
  @override
  DateTime get updatedAt => row.updatedAt;
  @override
  bool get deleted => row.deleted;

  HabitRow copyRow({DateTime? updatedAt, bool? synced}) {
    return row.copyWith(updatedAt: updatedAt, synced: synced);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Habit && row == other.row;
  }
  
  @override
  int get hashCode => row.hashCode;
}

enum HabitCategory {
  health,
  sports,
  wellbeing,
  study,
  work,
  reading,
  other;

  Color get color {
    switch (this) {
      case .health:
        return Colors.green;
      case .wellbeing:
        return Colors.teal;
      case .reading:
        return Colors.yellow;
      case .work:
        return Colors.orange;
      case .study:
        return Colors.purple;
      case .other:
        return Colors.grey;
      case .sports:
        return Colors.blue;
    }
  }

  (IconData outlined, IconData filled) _icon() {
    switch (this) {
      case .health:
        return (Icons.healing_outlined, Icons.healing);
      case .reading:
        return (Icons.book_outlined, Icons.book);
      case .work:
        return (Icons.work_outline, Icons.work);
      case .sports:
        return (Icons.sports_baseball_outlined, Icons.sports_baseball);
      case .wellbeing:
        return (Icons.self_improvement_outlined, Icons.self_improvement);
      case .study:
        return (Icons.school_outlined, Icons.school);
      case .other:
        return (Icons.category_outlined, Icons.category);
    }
  }

  IconData get iconOutlined => _icon().$1;
  IconData get iconFilled => _icon().$2;
}

@DataClassName('HabitRow')
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get frequencyPerWeek => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get category => intEnum<HabitCategory>()();

  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
