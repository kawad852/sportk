import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? radius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BoxFit boxFit;
  final ColorFilter? colorFilter;
  final Widget? child;
  final BoxShape? shape;
  final AlignmentGeometry alignment;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final Color? backgroundColor;

  const CustomNetworkImage(
    this.url, {
    super.key,
    this.radius,
    this.width,
    this.height,
    this.margin,
    this.boxFit = BoxFit.cover,
    this.colorFilter,
    this.shape,
    this.child,
    this.alignment = Alignment.center,
    this.onTap,
    this.border,
    this.backgroundColor,
  });

  Widget _buildContainer({ImageProvider? imageProvider, Color? color}) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: color,
        border: border,
        borderRadius: shape != null ? null : BorderRadius.circular(radius ?? MyTheme.radiusSecondary),
        image: imageProvider != null
            ? DecorationImage(
                image: imageProvider,
                fit: boxFit,
                colorFilter: colorFilter,
              )
            : null,
      ),
      child: child,
    );
  }

  ImageProvider get _imagePlaceHolder => const AssetImage('assets/splash.png');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => _buildContainer(color: backgroundColor, imageProvider: imageProvider),
        placeholder: (context, url) => _buildContainer(color: context.colorScheme.surfaceVariant, imageProvider: _imagePlaceHolder),
        errorWidget: (context, url, error) => _buildContainer(color: context.colorScheme.surfaceVariant, imageProvider: _imagePlaceHolder),
      ),
    );
  }
}
