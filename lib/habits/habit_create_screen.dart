import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitEditScreen extends ConsumerStatefulWidget {
  const HabitEditScreen({super.key, this.habit});
  // null for create, non-null for edit
  final Habit? habit;

  @override
  ConsumerState<HabitEditScreen> createState() => _HabitEditPageState();
}

class _HabitEditPageState extends ConsumerState<HabitEditScreen> {
  late final TextEditingController titleCtrl;
  late final TextEditingController descCtrl;
  late int freq;

  bool isLoading = false;
  String? error;

  bool get isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      titleCtrl = TextEditingController(text: widget.habit!.title);
      descCtrl = TextEditingController(text: widget.habit!.description);
      freq = widget.habit!.frequencyPerWeek;
    } else {
      titleCtrl = TextEditingController();
      descCtrl = TextEditingController();
      freq = 3;
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  bool get canSubmit {
    return titleCtrl.text.trim().isNotEmpty && !isLoading;
  }

  Future<void> submit() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      setState(() {
        error =
            'You must be logged in to ${isEditing ? 'edit' : 'create'} a habit';
        isLoading = false;
      });
      return;
    }

    final repo = ref.read(habitRepositoryProvider);

    final habit = Habit(
      id: widget.habit?.id ?? '', // Use existing ID for edit, empty for create
      title: titleCtrl.text.trim(),
      description: descCtrl.text.trim(),
      frequencyPerWeek: freq,
      createdAt:
          widget.habit?.createdAt ??
          DateTime.now(), // Preserve original date for edit
    );

    try {
      if (isEditing) {
        await repo.updateHabit(habit, userId);
      } else {
        await repo.createHabit(habit, userId);
      }
      if (!mounted) {
        return;
      }
      context.pop();
    } catch (err) {
      if (!mounted) {
        return;
      }
      setState(() {
        error = err.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Habit' : 'New Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Text('Times per week:'),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  value: freq,
                  onChanged: (v) => setState(() => freq = v!),
                  items: List.generate(
                    7,
                    (i) =>
                        DropdownMenuItem(value: i + 1, child: Text('${i + 1}')),
                  ),
                ),
              ],
            ),

            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canSubmit ? submit : null,
                child: isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isEditing ? 'Update Habit' : 'Create Habit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
