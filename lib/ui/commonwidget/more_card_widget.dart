import 'package:flutter/material.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/commonwidget/text_style.dart';

class MoreWidgetCard extends BaseStateLessWidget {
  final String assetName;
  final String text;
  final String iconAsset;

  const MoreWidgetCard(
      {Key? key,
      required this.assetName,
      required this.text,
      required this.iconAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: screenWidget / 2.3,
          height: screenWidget / 2.3,
          child: Image.asset(assetName),
        ),
        Positioned(
            left: screenWidget / 8 - 50,
            top: screenWidget / 8 - 20,
            child: SizedBox(
              width: screenWidget / 2.3,
              height: screenWidget / 2.3,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(iconAsset),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyles.headingTexStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontFamily: "assets/font/Oswald-Regular.ttf"),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
