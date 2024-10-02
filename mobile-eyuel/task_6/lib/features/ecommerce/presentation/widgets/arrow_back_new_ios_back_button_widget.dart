import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc/product_bloc.dart';

class ArrowNewIosBackButton extends StatelessWidget {
  const ArrowNewIosBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<ProductBloc>().add(LoadAllProductsEvent());
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new,
            color: Color.fromRGBO(63, 81, 243, 1)));
  }
}
