import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitEditScreen extends ConsumerStatefulWidget {
  const HabitEditScreen({super.key, this.habit});
  // null for create, non-null for edit
  final Habit? habit;

  @override
  ConsumerState<HabitEditScreen> createState() => _HabitEditScreenState();
}

class _HabitEditScreenState extends ConsumerState<HabitEditScreen> {
  late final TextEditingController titleCtrl;
  late final TextEditingController descCtrl;
  late int freq;

  bool get isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.habit?.row.title ?? '');
    descCtrl = TextEditingController(text: widget.habit?.row.description ?? '');
    freq = widget.habit?.row.frequencyPerWeek ?? 3;
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  bool get canSubmit {
    final state = ref.read(habitControllerProvider);
    return titleCtrl.text.trim().isNotEmpty && !state.isLoading;
  }

  Future<void> submit() async {
    final state = ref.read(habitControllerProvider);
    final controller = ref.read(habitControllerProvider.notifier);

    await controller.submit(
      existingHabit: widget.habit,
      title: titleCtrl.text.trim(),
      description: descCtrl.text.trim(),
      frequency: freq,
    );

    if (!state.hasError && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(habitControllerProvider);

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
                        DropdownMenuItem(value: i + 1, child: Text('${i + 1} per week')),
                  ),
                ),
              ],
            ),

            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(state.error.toString(), style: const TextStyle(color: Colors.red)),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canSubmit ? submit : null,
                child: state.isLoading
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
