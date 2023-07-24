import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/commonwidget/primary_elevated_button.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../controllers/product/product_list_controller.dart';
import '../../controllers/product/product_search_controller.dart';

class RangeWidget extends StatefulWidget {
  final ProductSearchController productController;

  const RangeWidget({Key? key, required this.productController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RangeWidget();
}

class _RangeWidget extends State<RangeWidget> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  static String _valueToString(double value) {
    return value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Min Price:${_currentRangeValues.start * 100}",
                style: TextStyles.headingTexStyle(color: Palette.kColorBlack),
              ),
              Text(
                "Max Price :${_currentRangeValues.end * 100}",
                style: TextStyles.headingTexStyle(color: Palette.kColorBlack),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Price",
          style: TextStyles.headingTexStyle(color: Palette.kColorBlack),
        ),
        const SizedBox(
          height: 20,
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 100,
          divisions: 10,
          labels: RangeLabels(
            (_currentRangeValues.start.round() * 100).toString(),
            (_currentRangeValues.end.round() * 100).toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              print(_currentRangeValues.toString());
              // widget.productController.callProductListApi();
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [cancelButton(), applyButton("20")],
        )
      ],
    );
  }

  Widget cancelButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn("Cancel", () async => {Get.back()},
            borderRadius: 40.0),
      ),
    );
  }

  Widget applyButton(String range) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn("Apply", () async => {Get.back()},
            borderRadius: 40.0),
      ),
    );
  }
}
