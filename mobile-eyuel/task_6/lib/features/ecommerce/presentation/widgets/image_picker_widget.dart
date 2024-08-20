import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/image_path/image_path.dart';
import '../../../../injection_container.dart';
import '../pages/add_product_page.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.imagePickerController,
  });
  final ImagePickerController imagePickerController;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final imagePath = sl<ImagePath>();
        final path = await imagePath.getImagePath();
        path.fold((failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
              backgroundColor: Colors.red,
              content: Text(failure.message),
            ),
          );
        }, (path) {
          setState(() {
            widget.imagePickerController.onImageSelected(path);
          });
        });
      },
      child: Container(
        width: 366,
        height: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.imagePickerController.imageUrl.value.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                    size: 50,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Upload Image'),
                ],
              )
            : Image.file(
                File(widget.imagePickerController.imageUrl.value),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
      ),
    );
  }
}
