import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'widget.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.product,
    this.height = 400,
  });

  final ProductEntity product;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            placeholder: (context, url) => const ImageLoadingShimmer(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
