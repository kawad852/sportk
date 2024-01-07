import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class SearchTextField extends StatefulWidget {
  final Function(String? value) onChanged;
  final String hintText;

  const SearchTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (value) {
        context.unFocusKeyboard();
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(
          Icons.search,
          size: 28,
        ),
      ),
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
