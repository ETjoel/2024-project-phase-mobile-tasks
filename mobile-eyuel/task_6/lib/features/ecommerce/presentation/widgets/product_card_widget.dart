import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'custom_cached_network_image_widget.dart';
import 'name_and_nating_listtile_widget.dart';

class ProductCards extends StatelessWidget {
  final ProductEntity product;
  final BuildContext context;
  const ProductCards({required this.context, required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.8,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CustomCachedNetworkImage(
                  product: product,
                  height: MediaQuery.of(context).size.height / 4),
            ),
            NameAndRatingListTile(product: product),
          ],
        ),
      ),
    );
  }
}
