import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Widget child;
  final double startValue;
  final EdgeInsetsGeometry padding;

  const CustomExpansionTile({
    Key? key,
    required this.child,
    required this.title,
    this.startValue = 0,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void toggleExpansion() {
    _controller.value == 1 ? _controller.reverse() : _controller.forward();
  }

  bool get _fullyExpanded => _controller.value == 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _controller.value = widget.startValue;
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        child: Material(
          color: context.colorPalette.grey9F9,
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  initiallyExpanded: widget.startValue == 1,
                  onExpansionChanged: (value) {
                    toggleExpansion();
                  },
                  collapsedBackgroundColor: context.colorPalette.grey9F9,
                  backgroundColor: context.colorPalette.grey9F9,
                  leading: null,
                  title: Text(
                    widget.title,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: _fullyExpanded ? context.colorScheme.primary : null,
                    ),
                  ),
                  trailing: RotationTransition(
                    turns: Tween(begin: 0.0, end: context.isLTR ? 0.5 : -0.5).animate(_controller),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: context.colorPalette.icon,
                    ),
                  ),
                ),
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: _animation,
                child: Container(
                  width: double.infinity,
                  color: context.colorPalette.grey9F9,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
