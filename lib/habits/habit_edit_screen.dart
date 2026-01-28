import 'dart:math';

import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitEditScreen extends ConsumerStatefulWidget {
  const HabitEditScreen({super.key, this.habitId});
  final String? habitId;

  @override
  ConsumerState<HabitEditScreen> createState() => _HabitEditScreenState();
}

class _HabitEditScreenState extends ConsumerState<HabitEditScreen> {
  late final TextEditingController titleCtrl;
  late final TextEditingController descCtrl;
  late int freq;
  late HabitCategory category;
  late String titleHint, descriptionHint;

  bool get isEditing => widget.habitId != null;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController();
    descCtrl = TextEditingController();
    freq = 3;
    category = HabitCategory.other;

    titleHint = _chooseRandom(['Meditate', 'Read', 'Run', 'Study', 'Stretch']);
    descriptionHint = _chooseRandom([
      'What motivates you?',
      'Which fear would this habit quietly dissolve?',
      'Go on...',
      'One proud thing to tell your past self',
      'How does this make you feel?',
      'You got this!',
    ]);

    ref.listenManual(habitProvider(widget.habitId), (prev, next) {
      if (next == null) {
        return;
      }
      titleCtrl.text = next.row.title;
      descCtrl.text = next.row.description;
      freq = next.row.frequencyPerWeek;
      category = next.row.category;
      setState(() {});
    }, fireImmediately: true);
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
    final habit = ref.watch(habitProvider(widget.habitId));

    await controller.submit(
      existingHabit: habit,
      title: titleCtrl.text.trim(),
      description: descCtrl.text.trim(),
      frequency: freq,
      category: category,
    );

    if (!state.hasError && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(habitControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Habit' : 'New Habit')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final titleFieldMaxWidth = constraints.maxWidth < 420
                            ? constraints.maxWidth
                            : 200.0;

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 12,
                            children: [
                              const Text(
                                'I want to',
                                style: TextStyle(color: Colors.white70),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: titleFieldMaxWidth,
                                  minWidth: 100,
                                ),
                                child: TextField(
                                  controller: titleCtrl,
                                  decoration: InputDecoration(
                                    hintText: titleHint,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                              const Text('at least'),
                              DropdownButton<int>(
                                value: freq,
                                onChanged: (v) => setState(() => freq = v!),
                                items: List.generate(
                                  7,
                                  (i) => DropdownMenuItem(
                                    value: i + 1,
                                    child: Text(
                                      i == 0 ? 'once' : '${i + 1} times',
                                    ),
                                  ),
                                ),
                              ),
                              const Text('per week.'),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: descCtrl,
                      decoration: InputDecoration(
                        labelText: 'Description (optional)',
                        hintText: descriptionHint,
                      ),
                      maxLines: 2,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 24),

                    _buildCategorySelector(),

                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          state.error.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }

  T _chooseRandom<T>(List<T> l) => l[Random().nextInt(l.length)];

  Widget _buildCategorySelector() {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Column(
          children: HabitCategory.values.map((cat) {
            final isSelected = cat == category;
            final color = cat.color;
            return Padding(
              padding: const .all(4),
              child: InkWell(
                borderRadius: .circular(16),
                onTap: () => setState(() => category = cat),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? scheme.primary.withValues(alpha: 0.2)
                        : scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(color: scheme.primary, width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? cat.iconFilled : cat.iconOutlined,
                        color: color,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        cat.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
