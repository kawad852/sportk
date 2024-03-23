import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({super.key});

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  int pointTeam1 = 0;
  int pointTeam2 = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Man City",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 60,
          height: 70,
          child: CupertinoPicker(
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            onSelectedItemChanged: (value) {
              setState(() {
                pointTeam1 = value;
              });
            },
            children: List.generate(
              30,
              (index) {
                return Text(index.toString());
              },
            ).toList(),
          ),
        ),
        VerticalDivider(
          color: context.colorPalette.greyAAA,
          thickness: 2,
          indent: 15,
          endIndent: 20,
        ),
        SizedBox(
          width: 60,
          height: 70,
          child: CupertinoPicker(
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            onSelectedItemChanged: (value) {
              setState(() {
                pointTeam2 = value;
              });
            },
            children: List.generate(
              30,
              (index) {
                return Text(index.toString());
              },
            ).toList(),
          ),
        ),
        const Expanded(
          child: Text(
            "Man City",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
