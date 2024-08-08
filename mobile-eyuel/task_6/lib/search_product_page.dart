import 'package:flutter/material.dart';
import 'product_card.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  bool showBottomSheet = false;

  void _toggleBottomSheet() {
    setState(() {
      showBottomSheet = !showBottomSheet;
    });

    if (showBottomSheet) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        barrierColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const BottomSheetComponent();
        },
      ).whenComplete(() {
        // Reset the boolean when the bottom sheet is dismissed
        setState(() {
          showBottomSheet = false;
        });
      });
    }
  }

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
              color: Color.fromRGBO(63, 81, 243, 1)),
        ),
        title: const Text('Search Product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: searchNFilterComponent(),
          ),
          Expanded(child: ListProduct()),
        ],
      ),
    );
  }

  Widget searchNFilterComponent() {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 300,
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.arrow_forward_sharp,
                  color: Color.fromRGBO(63, 81, 243, 1)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: _toggleBottomSheet,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color.fromRGBO(63, 81, 243, 1),
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
}

class BottomSheetComponent extends StatefulWidget {
  const BottomSheetComponent({super.key});

  @override
  State<BottomSheetComponent> createState() => _BottomSheetComponentState();
}

class _BottomSheetComponentState extends State<BottomSheetComponent> {
  RangeValues _currentRangeValues = const RangeValues(100, 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Category',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          catagoryTextField(),
          const SizedBox(height: 10),
          const Text('price', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          rangeWidget(),
          const SizedBox(height: 10),
          applyButton(),
        ],
      ),
    );
  }

  RangeSlider rangeWidget() {
    return RangeSlider(
      values: _currentRangeValues,
      activeColor: Color.fromRGBO(63, 81, 243, 1),
      inactiveColor: Colors.grey.shade300,
      onChanged: (RangeValues value) {
        setState(() {
          _currentRangeValues = value;
        });
      },
      min: 0,
      max: 1000,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
    );
  }

  Container catagoryTextField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
        ),
      ),
    );
  }

  Widget priceRange() {
    return RangeSlider(
      values: _currentRangeValues,
      activeColor: Color.fromRGBO(63, 81, 243, 1),
      inactiveColor: Colors.grey.shade200,
      onChanged: (RangeValues value) {
        setState(() {
          _currentRangeValues = value;
        });
      },
      min: 0,
      max: 1000,
    );
  }

  TextButton applyButton() {
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
            'Apply',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}
