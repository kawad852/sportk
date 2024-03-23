import 'package:flutter/cupertino.dart';

class ResultPicker extends StatefulWidget {
  final void Function(int) onSelectedItemChanged;
  const ResultPicker({super.key, required this.onSelectedItemChanged});

  @override
  State<ResultPicker> createState() => _ResultPickerState();
}

class _ResultPickerState extends State<ResultPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 70,
      child: CupertinoPicker(
        itemExtent: 30,
        scrollController: FixedExtentScrollController(initialItem: 1),
        onSelectedItemChanged: widget.onSelectedItemChanged,
        children: List.generate(
          30,
          (index) {
            return Text(index.toString());
          },
        ).toList(),
      ),
    );
  }
}
