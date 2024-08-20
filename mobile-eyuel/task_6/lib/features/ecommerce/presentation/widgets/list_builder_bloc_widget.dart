import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc/product_bloc.dart';
import 'widget.dart';

class ListBuilderBloc extends StatelessWidget {
  const ListBuilderBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is AllProductsLoading) {
        return const Center(
          child: ListLoadingShimmer(),
        );
      } else if (state is AllProductsLoaded) {
        return Expanded(child: ListProduct(products: state.products));
      } else if (state is ProductError) {
        return Center(
          child: ErrorShow(message: state.message),
        );
      } else {
        return const Text('Something went wrong');
      }
    });
  }
}
