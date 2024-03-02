import 'package:flutter/material.dart';
import 'package:sportk/widgets/base_editor.dart';

class SearchTextField extends StatefulWidget {
  final Function(String? value) onChanged;
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;

  const SearchTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    return BaseEditor(
      hintText: widget.hintText,
      prefixIcon: const Icon(
        Icons.search,
        size: 28,
      ),
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            _searchQuery = null;
          } else {
            _searchQuery = value;
          }
        });
        widget.onChanged(_searchQuery);
      },
      autofocus: true,
    );
  }
}
