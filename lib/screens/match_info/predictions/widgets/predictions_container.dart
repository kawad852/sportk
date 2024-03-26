import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PredictionsContainer extends StatefulWidget {
  final int index;
  final int selectedCard;
  final bool isDraw;
  final String team;
  final String teamLogo;
  const PredictionsContainer({
    super.key,
    required this.index,
    required this.selectedCard,
    this.isDraw = false,
    required this.team,
    required this.teamLogo,
  });

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
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
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
                CustomNetworkImage(
                  widget.teamLogo,
                  width: 50,
                  height: 50,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.team,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: widget.selectedCard == widget.index
                            ? context.colorPalette.white
                            : context.colorPalette.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
