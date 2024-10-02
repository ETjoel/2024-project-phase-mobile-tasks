import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../widgets/widget.dart';

class ImagePickerController extends GetxController {
  final imageUrl = ''.obs;

  void onImageSelected(String path) {
    imageUrl.value = path;
  }
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final imagePickerController = Get.put(ImagePickerController());
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const ArrowNewIosBackButton(),
        title: const Text('Add Product'),
      ),
      body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is CreateProductLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: ThreeDotWaiting(size: 30),
                  );
                },
              );
            } else if (state is CreateProductLoaded) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                  content: Text('Product added successfully'),
                ),
              );
            } else if (state is ProductError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(20),
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePickerWidget(imagePickerController: imagePickerController),
                const SizedBox(height: 10),
                const Text('name'),
                const SizedBox(height: 10),
                CustomTextField(
                  nameController: nameController,
                  key: const Key('NAME_TEXTFIELD'),
                ),
                const SizedBox(height: 10),
                const Text('category'),
                const SizedBox(height: 10),
                CustomTextField(
                  nameController: categoryController,
                  key: const Key('CATAGORY_TEXTFIELD'),
                ),
                const SizedBox(height: 10),
                const Text('price'),
                const SizedBox(height: 10),
                PriceTextField(
                  priceController: priceController,
                  key: const Key('PRICE_TEXTFIELD'),
                ),
                const SizedBox(height: 10),
                const Text('description'),
                const SizedBox(height: 10),
                DescriptionTextField(
                  descriptionTextField: descriptionController,
                  key: const Key('DESCRIPTION_TEXTFIELD'),
                ),
                const SizedBox(height: 10),
                AddButton(
                  key: const Key('ADD_BUTTON'),
                  name: 'Add',
                  onPressed: () {
                    onPressed(context);
                  },
                ),
                const SizedBox(height: 5),
                DeleteButton(onPressed: () {
                  setState(() {
                    imagePickerController.onImageSelected('');
                  });
                }),
              ],
            ),
          )),
    );
  }

  void onPressed(BuildContext context) {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        !priceController.text.isNumericOnly ||
        imagePickerController.imageUrl.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        backgroundColor: Colors.red,
        content: Text('Please fill all the fields'),
      ));
    } else {
      final productModel = ProductModel(
        id: '',
        name: nameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        imageUrl: imagePickerController.imageUrl.value,
      );

      context.read<ProductBloc>().add(CreateProductEvent(productModel));
    }
  }
}
