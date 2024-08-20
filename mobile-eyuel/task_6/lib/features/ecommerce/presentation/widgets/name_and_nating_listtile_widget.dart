import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class NameAndRatingListTile extends StatelessWidget {
  const NameAndRatingListTile({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        product.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('This is a product type'),
      trailing: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${product.price}'),
            const SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text('(4.0)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
