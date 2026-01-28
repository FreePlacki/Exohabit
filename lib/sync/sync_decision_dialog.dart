import 'package:flutter/material.dart';

enum SyncChoice { merge, override }

class SyncDecisionDialog extends StatelessWidget {
  const SyncDecisionDialog({super.key, required bool isCreatingNewAccount})
    : _isCreatingNewAccount = isCreatingNewAccount;
  final bool _isCreatingNewAccount;

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
          child: Text(
            _isCreatingNewAccount ? 'Start fresh' : 'Replace local data',
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, SyncChoice.merge),
          child: Text(_isCreatingNewAccount ? 'Copy your data' : 'Merge'),
        ),
      ],
    );
  }
}
