import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/shimmer_loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final double? shimmerWidth, shimmerHeight, shimmerRadiusValue;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? shimmerBaseColor, shimmerHighlightColor;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomCachedNetworkImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.shimmerWidth,
    this.shimmerHeight,
    this.shimmerRadiusValue,
    this.fit,
    this.borderRadius,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.placeholder,
    this.errorWidget,
  });

  String fixImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return "https://flower.elevateegy.com/uploads/default-profile.png";
    }
    url = url.replaceAll("https://flower.elevateegy.com/uploads/", "");
    if (!url.startsWith("http")) {
      return "https://flower.elevateegy.com/uploads/$url";
    }

    return url;
  }


  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: fixImageUrl(imageUrl),
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
        placeholder ??
            ShimmerLoadingWidget(
              width: shimmerWidth ?? 24,
              height: shimmerHeight ?? 24,
              borderRadius: shimmerRadiusValue,
            ),
        errorWidget: (context, url, error) => errorWidget ?? Icon(Icons.error),
      ),
    );
  }
}
