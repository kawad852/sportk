import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class PlayerCardLoading extends StatelessWidget {
  const PlayerCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: context.colorPalette.grey2F2,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          width: 80,
          height: 15,
          margin: const EdgeInsetsDirectional.only(top: 5, bottom: 30),
          color: context.colorPalette.grey2F2,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 80,
                height: 50,
                margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
