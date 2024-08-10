import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'product_model.dart';

class ListProduct extends StatelessWidget {
  ListProduct({
    super.key,
  });

  final Product product = Product(
    'Derby Leather Shoes',
    'Men\'s Shoes',
    120,
    '''A derby leather shoe is a classic and versatile 
    footwear option characterized by its open lacing system, 
    where the shoelace eyelets are sewn on top of the vamp 
    (the upper part of the shoe). This design feature provides a more 
    relaxed and casual look compared to the closed lacing system of 
    oxford shoes. Derby shoes are typically made of high-quality leather, 
    known for its durability and elegance, making them suitable for both formal and 
    casual occasions. With their timeless style and comfortable fit, 
    derby leather shoes are a staple in any well-rounded wardrobe.''',
    'images/lv_shoe.jpeg',
    42,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, pageTransition());
            },
            child: const ProductCards(),
          ),
        );
      },
    );
  }

  PageRouteBuilder<dynamic> pageTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          DetailPage(product: product),
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

class ProductCards extends StatelessWidget {
  const ProductCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('images/lv_shoe.jpeg'),
                  ),
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'Derby Leather Shoes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Men's Shoes"),
              trailing: SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$120'),
                    SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text('(4.0)'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
