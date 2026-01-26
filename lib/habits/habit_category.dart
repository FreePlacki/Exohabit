import 'package:flutter/material.dart';

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
