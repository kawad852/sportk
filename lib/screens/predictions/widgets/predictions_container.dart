import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PredictionsContainer extends StatefulWidget {
  final int index;
  final int selectedCard;
  final bool isDraw;
  const PredictionsContainer(
      {super.key, required this.index, required this.selectedCard, this.isDraw = false});

  @override
  State<PredictionsContainer> createState() => _PredictionsContainerState();
}

class _PredictionsContainerState extends State<PredictionsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.selectedCard == widget.index
            ? context.colorPalette.blueD4B
            : context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.isDraw
          ? Text(
              context.appLocalization.drawText,
              style: TextStyle(
                color: widget.selectedCard == widget.index
                    ? context.colorPalette.white
                    : context.colorPalette.black,
                fontWeight: FontWeight.bold,
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CustomNetworkImage(
                  kFakeImage,
                  width: 50,
                  height: 50,
                ),
                Text(
                  "Man city",
                  style: TextStyle(
                    color: widget.selectedCard == widget.index
                        ? context.colorPalette.white
                        : context.colorPalette.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
