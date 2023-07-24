import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';
import 'package:mcsofttech/utils/palette.dart';

class DataNotFound extends BaseStateLessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidget,
      height: screenHeight,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight / 3,
          ),
          Text(
            "DATA NOT FOUND!",
            style: TextStyles.headingTexStyle(
                color: Palette.kColorRed,
                fontFamily: "assets/font/Oswald-Bold.ttf"),
          )
        ],
      ),
    );
  }
}
