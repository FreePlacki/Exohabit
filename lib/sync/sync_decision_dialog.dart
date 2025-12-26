import 'package:flutter/material.dart';

enum SyncChoice { merge, override }

class SyncDecisionDialog extends StatelessWidget {
  const SyncDecisionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sync habits'),
      content: const Text(
        'You already have habits stored on this device.\n\n'
        'How do you want to sync them with your account?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, SyncChoice.override),
          child: const Text('Replace local data'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, SyncChoice.merge),
          child: const Text('Merge'),
        ),
      ],
    );
  }
}
