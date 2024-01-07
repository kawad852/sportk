import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class SearchTextField extends StatefulWidget {
  final Function(String? value) onChanged;
  final VoidCallback onPressed;

  const SearchTextField({
    super.key,
    required this.onChanged,
    required this.onPressed,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: _searchQuery != null ? (v) => widget.onPressed() : null,
      decoration: InputDecoration(
        hintText: context.appLocalization.search,
        suffixIcon: IconButton(
          onPressed: _searchQuery != null ? widget.onPressed : null,
          icon: const Icon(Icons.search),
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
