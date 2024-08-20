import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../widgets/widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});
  final ProductEntity product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: floatingActionButton(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is DeleteProductLoading) {
              _showDialog(context);
            } else if (state is DeleteProductLoaded) {
              context.read<ProductBloc>().add(LoadAllProductsEvent());
              Navigator.pop(context);
              Navigator.pop(context, true);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                  content: Text('Product added successfully'),
                ),
              );
            } else if (state is UpdateProductLoading) {
              _showDialog(context);
            } else if (state is UpdateProductLoaded) {
              Navigator.pop(context);
            } else if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(20),
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
            }
          });

          return singleChildScrollView(context);
        },
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: ThreeDotWaiting(size: 40),
          );
        });
  }

  Widget singleChildScrollView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCachedNetworkImage(
            product: widget.product,
            height: MediaQuery.of(context).size.height / 3.4),
        NameAndRatingListTile(product: widget.product),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: Text(
            'Size: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizeSelector(),
        SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Text(
            widget.product.description,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 5,
          ),
          child: Row(
            children: [
              DeleteButton(
                  width: 150,
                  onPressed: () {
                    context
                        .read<ProductBloc>()
                        .add(DeleteProductEvent(widget.product.id));
                  }),
              const Spacer(),
              AddButton(
                name: 'Update',
                width: 150,
                onPressed: () {
                  context.read<ProductBloc>().add(UpdateProductEvent(
                      ProductModel(
                          id: widget.product.id,
                          name: widget.product.name,
                          price: widget.product.price,
                          description: widget.product.description,
                          imageUrl: widget.product.imageUrl)));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      mini: true,
      elevation: 1,
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Center(
        child: Icon(Icons.chevron_left,
            size: 30, color: Color.fromRGBO(63, 81, 243, 1)),
      ),
    );
  }
}
