import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Color.fromRGBO(63, 81, 243, 1))),
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            uploadImage(),
            const SizedBox(height: 10),
            const Text('name'),
            const SizedBox(height: 10),
            nameTextField(),
            const SizedBox(height: 10),
            const Text('category'),
            const SizedBox(height: 10),
            nameTextField(),
            const SizedBox(height: 10),
            const Text('price'),
            const SizedBox(height: 10),
            nameTextField(),
            const SizedBox(height: 10),
            const Text('description'),
            const SizedBox(height: 10),
            descriptionTextField(),
            const SizedBox(height: 10),
            addButton(),
            const SizedBox(height: 5),
            deleteButton(),
          ],
        ),
      ),
    );
  }

  TextButton deleteButton() {
    return TextButton(
        onPressed: () {},
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.redAccent)),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.redAccent, fontSize: 20),
          ),
        ));
  }

  TextButton addButton() {
    return TextButton(
        onPressed: () {},
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(63, 81, 243, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }

  Container nameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container descriptionTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        minLines: 5,
        maxLines: 10,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }

  BackButton backButton(BuildContext context) {
    return BackButton(
      style: ButtonStyle(
        iconColor: MaterialStateColor.resolveWith(
            (states) => Color.fromRGBO(63, 81, 243, 1)),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget uploadImage() {
    return Container(
        width: 366,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo,
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text('Upload Image'),
          ],
        ));
  }
}
