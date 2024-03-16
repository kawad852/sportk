import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';

class FavoriteButton extends StatefulWidget {
  final int id;
  final String? name;
  final String type;
  final bool showDialog;

  const FavoriteButton({
    super.key,
    required this.id,
    required this.type,
    this.name,
    this.showDialog = false,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late FavoriteProvider _favoriteProvider;

  int get _id => widget.id;

  String get _type => widget.type;

  @override
  void initState() {
    super.initState();
    _favoriteProvider = context.favoriteProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FavoriteProvider, bool>(
      selector: (context, provider) => provider.isFav(_id, _type),
      builder: (context, isFav, child) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: FilledButton(
            onPressed: () async {
              _favoriteProvider.toggleFavorites(
                context,
                _id,
                _type,
                widget.name,
                showDialog: widget.showDialog,
              );
            },
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              backgroundColor: context.colorScheme.surface,
              minimumSize: const Size.fromRadius(15),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: CustomSvg(
              isFav ? MyIcons.starFilled : MyIcons.starOutlined,
              color: context.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
