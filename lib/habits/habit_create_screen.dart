import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitCreateScreen extends ConsumerStatefulWidget {
  const HabitCreateScreen({super.key});

  @override
  ConsumerState<HabitCreateScreen> createState() => _HabitCreatePageState();
}

class _HabitCreatePageState extends ConsumerState<HabitCreateScreen> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  int freq = 3; // default frequency

  bool isLoading = false;
  String? error;

  bool get canSubmit {
    return titleCtrl.text.trim().isNotEmpty &&
           !isLoading;
  }

  Future<void> submit() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      setState(() {
        error = 'You must be logged in to create a habit';
        isLoading = false;
      });
      return;
    }

    final repo = ref.read(habitRepositoryProvider);

    final habit = Habit(
      id: "", // Firestore sets this
      title: titleCtrl.text.trim(),
      description: descCtrl.text.trim(),
      frequencyPerWeek: freq,
      createdAt: DateTime.now(),
    );

    try {
      await repo.createHabit(habit, userId);
      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: "Title"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Text("Times per week:"),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  value: freq,
                  onChanged: (v) => setState(() => freq = v!),
                  items: List.generate(
                    7,
                    (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text("${i + 1}"),
                    ),
                  ),
                ),
              ],
            ),

            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                ),
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
                    : const Text("Create Habit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}