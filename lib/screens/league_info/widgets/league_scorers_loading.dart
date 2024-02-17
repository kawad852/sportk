import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class LeagueScorersLoading extends StatelessWidget {
  const LeagueScorersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // TODO: Mihyar: loadingBubble instead
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: context.colorPalette.grey3F3,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6, // TODO: Mihyar: increase it to fill the screen (make it scrollable) make it scrollable to not have an overFlow error
            itemBuilder: (BuildContext context, int index) {
              // TODO: Mihyar: loadingBubble instead
              return Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: context.colorPalette.grey3F3,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
