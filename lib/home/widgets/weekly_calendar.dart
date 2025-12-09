import 'package:flutter/material.dart';

class WeeklyCalendarStrip extends StatelessWidget {
  const WeeklyCalendarStrip({
    super.key,
    required this.weekdayCounts,
  }) : assert(weekdayCounts.length == 7);

  final List<int> weekdayCounts; // Monday-first

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday - DateTime.monday;
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final count = weekdayCounts[i];
        final isToday = i == todayIndex;
        final hasCompleted = count > 0;

        return Column(
          children: [
            Text(
              labels[i],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isToday ? Colors.deepPurple : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasCompleted
                    ? Colors.green.withOpacity(0.2)
                    : Colors.grey.shade200,
                border: Border.all(
                  color: isToday ? Colors.deepPurple : Colors.grey.shade300,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                count > 0 ? '$count' : '',
                style: TextStyle(
                  color: hasCompleted ? Colors.green[800] : Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

