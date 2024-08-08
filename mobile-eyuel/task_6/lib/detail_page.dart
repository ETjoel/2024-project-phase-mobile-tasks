import 'package:flutter/material.dart';
import 'package:task_6/product_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});
  final Product product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late int selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: floatingActionButton(),
      body: singleChildScrollView(),
    );
  }

  SingleChildScrollView singleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productImage(),
          typeAndRating(),
          nameAndprice(),
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
          selectSize(),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          deleteAndUpdate(),
        ],
      ),
    );
  }

  Padding deleteAndUpdate() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 5,
      ),
      child: Row(
        children: [
          deleteProduct(),
          const Spacer(),
          updateProduct(),
        ],
      ),
    );
  }

  TextButton updateProduct() {
    return TextButton(
        onPressed: () {},
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(63, 81, 243, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Update',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
          ),
        ));
  }

  TextButton deleteProduct() {
    return TextButton(
        onPressed: () {},
        child: Container(
          alignment: Alignment.center,
          width: 150,
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

  SizedBox selectSize() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 10,
        itemExtent: null,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 60,
            width: 60,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = index + 38;
                  debugPrint('$selectedSize');
                });
              },
              child: Card(
                elevation: 2,
                surfaceTintColor: Colors.white,
                color: selectedSize == index + 38 ? Colors.blue : Colors.white,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 38}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding nameAndprice() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text('\$${widget.product.price}'),
        ],
      ),
    );
  }

  Padding typeAndRating() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(widget.product.category),
          const Spacer(),
          const Icon(Icons.star, color: Colors.yellow),
          const Text('(4.0)'),
        ],
      ),
    );
  }

  Widget productImage() {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset(widget.product.imageUrl),
        ),
      ),
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
