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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UploadImage(),
            SizedBox(height: 10),
            Text('name'),
            SizedBox(height: 10),
            CustomTextField(),
            SizedBox(height: 10),
            Text('category'),
            SizedBox(height: 10),
            CustomTextField(),
            SizedBox(height: 10),
            Text('price'),
            SizedBox(height: 10),
            CustomTextField(),
            SizedBox(height: 10),
            Text('description'),
            SizedBox(height: 10),
            DescriptionTextField(),
            SizedBox(height: 10),
            AddButton(),
            SizedBox(height: 5),
            DeleteButton(),
          ],
        ),
      ),
    );
  }
}

class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BackButton(
      style: ButtonStyle(
        iconColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromRGBO(63, 81, 243, 1)),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(63, 81, 243, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
