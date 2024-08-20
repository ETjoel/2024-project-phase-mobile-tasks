import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../widgets/widget.dart';

class SearchPageStateController extends GetxController {
  final _currentRangeValues = const RangeValues(200, 500).obs;
  final _showBottomSheet = false.obs;
  RangeValues get currentRangeValues => _currentRangeValues.value;
  set currentRangeValues(RangeValues value) =>
      _currentRangeValues.value = value;
  bool get showBottomSheet => _showBottomSheet.value;
  set showBottomSheet(bool value) => _showBottomSheet.value = value;
}

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final SearchPageStateController searchPageStateController =
      Get.put(SearchPageStateController());
  bool filter = false;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const ArrowNewIosBackButton(),
        title: const Text('Search Product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: searchNFilterComponent(),
          ),
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is AllProductsLoading) {
              return const Center(
                child: ListLoadingShimmer(),
              );
            } else if (state is AllProductsLoaded) {
              return Expanded(
                  child:
                      ListProduct(products: filteredProduct(state.products)));
            } else if (state is ProductError) {
              return Center(
                child: ErrorShow(message: state.message),
              );
            } else {
              return const Center(
                child: Text('No Products'),
              );
            }
          }),
        ],
      ),
    );
  }

  List<ProductEntity> filteredProduct(List<ProductEntity> _products) {
    List<ProductEntity> products = _products;
    if (filter && _products.isNotEmpty) {
      final productsIndex = _products.map((product) {
        if (product.price >=
                searchPageStateController.currentRangeValues.start &&
            product.price <= searchPageStateController.currentRangeValues.end &&
            product.name.contains(nameController.text)) {
          return true;
        } else {
          return false;
        }
      }).toList();
      products = [];
      for (var i = 0; i < productsIndex.length; i++) {
        if (productsIndex[i]) {
          products.add(_products[i]);
        }
      }
    }
    return products;
  }

  Widget searchNFilterComponent() {
    return Row(
      children: [
        SearchTextField(
          nameController: nameController,
          onSubmitted: () {
            setState(() {
              filter = true;
            });
          },
        ),
        const Spacer(),
        TextButton(
          onPressed: _toggleBottomSheet,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color.fromRGBO(63, 81, 243, 1),
            ),
            child: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleBottomSheet() {
    setState(() {
      searchPageStateController.showBottomSheet =
          !searchPageStateController.showBottomSheet;
    });

    if (searchPageStateController.showBottomSheet) {
      _showModelBottomSheet().whenComplete(() {
        setState(() {
          searchPageStateController.showBottomSheet = false;
        });
      });
    }
  }

  Future<dynamic> _showModelBottomSheet() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomSheetComponent(
          searchPageStateController: searchPageStateController,
          onPressed: () {
            setState(() {
              filter = true;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
