import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/module/news_and_video/news_details.dart';
import 'package:mcsofttech/ui/module/videos/VideoNewsDetail.dart';
import 'package:mcsofttech/utils/common_util.dart';
import '../../../../../models/product_filter_model.dart';
import '../../../../models/meridukaan/EquiryList.dart';
import '../../../../models/newandvideo/News.dart';
import '../../../commonwidget/text_style.dart';

class EnquiryDataCard extends BaseStateLessWidget {
  const EnquiryDataCard({required this.equiryData, super.key});

  final EquiryList equiryData;


  @override
  Widget build(BuildContext context) {
    debugPrint("${Constant.baseUrl}/${equiryData.productImg}");
    return SizedBox(
      width: screenWidget,
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: .5, color: MyColors.kColorGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage.assetNetwork(
                          width: 78,
                          height: 78,
                          fit: BoxFit.fill,
                          placeholder: "assets/png/placeholder.png",
                          image:
                              "${Constant.baseUrl}/${equiryData.productImg}")),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  header,
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Text("${equiryData.userName}${equiryData.mobile}\n${equiryData.email}",
                        maxLines: 2,
                        style: TextStyles.headingTexStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: MyColors.colorTextGrey,
                            fontFamily: "assets/font/Oswald-Regular.ttf")),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Text(Common.dateParsing(equiryData.createDate),
                        maxLines: 2,
                        style: TextStyles.headingTexStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: MyColors.colorTextGrey,
                            fontFamily: "assets/font/Oswald-Regular.ttf")),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget get header {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          "${equiryData.productName}",
          style: TextStyles.headingTexStyle(
              color: MyColors.themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }


}
