import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../pages/search_product_page.dart';
import 'add_product_button_widget.dart';
import 'custom_text_field_widget.dart';

class BottomSheetComponent extends StatefulWidget {
  final SearchPageStateController searchPageStateController;
  final Function onPressed;
  const BottomSheetComponent(
      {super.key,
      required this.searchPageStateController,
      required this.onPressed});

  @override
  State<BottomSheetComponent> createState() => _BottomSheetComponentState();
}

class _BottomSheetComponentState extends State<BottomSheetComponent> {
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
          CustomTextField(nameController: TextEditingController()),
          const SizedBox(height: 10),
          const Text('price', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          rangeWidget(),
          const SizedBox(height: 10),
          AddButton(name: 'Apply', onPressed: widget.onPressed),
        ],
      ),
    );
  }

  Widget rangeWidget() {
    return SliderTheme(
      data: const SliderThemeData(
        valueIndicatorTextStyle: TextStyle(color: primaryColor),
        valueIndicatorColor: Colors.white,
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: RangeSlider(
        values: widget.searchPageStateController.currentRangeValues,
        activeColor: primaryColor,
        inactiveColor: Colors.grey.shade300,
        onChanged: (RangeValues value) {
          setState(() {
            widget.searchPageStateController.currentRangeValues = value;
          });
        },
        min: 0,
        max: 1000,
        labels: RangeLabels(
          widget.searchPageStateController.currentRangeValues.start
              .round()
              .toString(),
          widget.searchPageStateController.currentRangeValues.end
              .round()
              .toString(),
        ),
      ),
    );
  }

  Widget priceRange() {
    return RangeSlider(
      values: widget.searchPageStateController.currentRangeValues,
      activeColor: const Color.fromRGBO(63, 81, 243, 1),
      inactiveColor: Colors.grey.shade200,
      onChanged: (RangeValues value) {
        setState(() {
          widget.searchPageStateController.currentRangeValues = value;
        });
      },
      min: 0,
      max: 1000,
    );
  }
}
