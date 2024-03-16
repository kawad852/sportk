import 'package:flutter/material.dart';
import 'package:sportk/helper/validation_helper.dart';
import 'package:sportk/widgets/base_editor.dart';

class EmailEditor extends StatelessWidget {
  final String? initialValue;
  final Function(String?) onChanged;
  final bool readonly;

  const EmailEditor({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseEditor(
      initialValue: initialValue,
      keyboardType: TextInputType.emailAddress,
      required: true,
      readOnly: readonly,
      onChanged: (value) {
        if (value.isEmpty) {
          onChanged(null);
        } else {
          onChanged(value);
        }
      },
      validator: (value) => ValidationHelper.email(context, value),
    );
  }
}
