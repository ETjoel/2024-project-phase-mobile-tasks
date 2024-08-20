import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedSize = -1;
  @override
  Widget build(BuildContext context) {
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
}
