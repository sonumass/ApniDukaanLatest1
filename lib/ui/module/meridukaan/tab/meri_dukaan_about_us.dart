import 'package:flutter/material.dart';

import '../../../../models/meridukaan/meri_dukaan_model.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';

class AboutUsStatefulWidget extends StatefulWidget {
  final MeriDukaanModel? meriDukaanModel;

  const AboutUsStatefulWidget({Key? key, required this.meriDukaanModel})
      : super(key: key);

  @override
  State<AboutUsStatefulWidget> createState() => _AboutUsStatefulWidgetState();
}

class _AboutUsStatefulWidgetState extends State<AboutUsStatefulWidget> {
  double width = 0.0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: double.maxFinite,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
            height: double.maxFinite,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
              children: [
                aboutUsText,
                const SizedBox(
                  width: 140,
                  child: Divider(color: Colors.red, height: 20.0, thickness: 5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: columnForYearAndCompany,
                ),
              ],
            ))),
      ),
    );
  }

  Widget get aboutUsText {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          "About Us",
          style: TextStyles.headingTexStyle(color: Colors.green),
        ),
      ),
    );
  }

  Widget get columnForYearAndCompany {
    return Column(
      children: [
        rowCompany,
        rowForYear,
        rowForNatureOfBusiness,
        Text(
          ": ${widget.meriDukaanModel?.dukanDetails?.aboutUs ?? ""}",
          style: TextStyles.labelTextStyle(color: Palette.kColorDarkGrey),
        ),
      ],
    );
  }

  Widget get rowCompany {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 2.4,
              child: Text(
                "Company Name",
                style: TextStyles.headingTexStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              width: width / 2.4,
              child: Text(
                ": ${widget.meriDukaanModel?.dukanDetails?.name ?? ""}",
                style: TextStyles.labelTextStyle(color: Palette.kColorDarkGrey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get rowForYear {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 2.4,
              child: Text(
                "Year of Est.",
                style: TextStyles.headingTexStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              width: width / 2.4,
              child: Text(
                ": ${widget.meriDukaanModel?.dukanDetails?.yrsOfEst ?? ""}",
                style: TextStyles.labelTextStyle(color: Palette.kColorDarkGrey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get rowForNatureOfBusiness {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 2.4,
              child: Text(
                "Nature Of Business",
                style: TextStyles.headingTexStyle(color: Colors.black),
              ),
            ),
            Expanded(
                child: Text(
              ": ${widget.meriDukaanModel?.dukanDetails?.tagLine ?? ""}",
              style: TextStyles.labelTextStyle(color: Palette.kColorDarkGrey),
            )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
