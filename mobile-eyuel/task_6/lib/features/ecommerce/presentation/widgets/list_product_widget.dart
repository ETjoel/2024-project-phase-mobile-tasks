import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../pages/detail_page.dart';
import 'product_card_widget.dart';

class ListProduct extends StatelessWidget {
  final List<ProductEntity> products;
  const ListProduct({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, pageTransition(index));

              // if (shouldReload != null && shouldReload) {
              //   // ignore: use_build_context_synchronously
              //   context.read<ProductBloc>().add(LoadAllProductsEvent());
              // }
            },
            child: ProductCards(context: context, product: products[index]),
          ),
        );
      },
    );
  }

  PageRouteBuilder<dynamic> pageTransition(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return BlocProvider.value(
            value: context.read<ProductBloc>(),
            child: DetailPage(product: products[index]));
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
