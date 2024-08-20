import 'package:flutter/material.dart';

import '../pages/search_product_page.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Row(
        children: [
          const Text('Available Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                pageTransition(),
              );
            },
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey.shade400)),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.grey.shade400,
                )),
          ),
        ],
      ),
    );
  }

  PageRouteBuilder<dynamic> pageTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchProduct(),
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
