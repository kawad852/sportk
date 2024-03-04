import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/web_view_screen.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class MatchCard extends StatefulWidget {
  final MatchData element;
  final int homeGoals;
  final int awayGoals;
  final int? minute;
  const MatchCard({
    super.key,
    required this.element,
    required this.homeGoals,
    required this.awayGoals,
    required this.minute,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        context.push(WebViewScreen(
          matchId: widget.element.id!,
        ));
      },
      child: Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsetsDirectional.only(bottom: 10),
        decoration: BoxDecoration(
          color: context.colorPalette.blueE2F,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                widget.element.participants![0].name!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            CustomNetworkImage(
              widget.element.participants![0].imagePath!,
              width: 30,
              height: 30,
              shape: BoxShape.circle,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.element.state!.id != 1 &&
                          widget.element.state!.id != 13 &&
                          widget.element.state!.id != 10
                      ? Text("${widget.homeGoals}")
                      : const SizedBox(
                          width: 6,
                        ),
                  widget.minute != null
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                          child: CircleAvatar(
                            child: Text("${widget.minute}"),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.element.state!.name!,
                                style: TextStyle(
                                  color: context.colorPalette.green057,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              if (widget.element.state!.id == 1)
                                Text(
                                  DateFormat("yyyy-MM-dd").format(widget.element.startingAt!),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (widget.element.state!.id == 1)
                                Text(
                                  DateFormat("HH:mm").format(widget.element.startingAt!),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                  widget.element.state!.id != 1 &&
                          widget.element.state!.id != 13 &&
                          widget.element.state!.id != 10
                      ? Text("${widget.awayGoals}")
                      : const SizedBox(
                          width: 6,
                        )
                ],
              ),
            ),
            CustomNetworkImage(
              widget.element.participants![1].imagePath!,
              width: 30,
              height: 30,
              shape: BoxShape.circle,
            ),
            Expanded(
              flex: 1,
              child: Text(
                widget.element.participants![1].name!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
