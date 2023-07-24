import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/module/testimonial/testimonial_details.dart';
import '../../../../../models/product_filter_model.dart';
import '../../../models/testimonial/Testimonial.dart';
import '../../commonwidget/text_style.dart';

class TestimonialCard extends BaseStateLessWidget {
  const TestimonialCard({required this.listData,required this.list,required this.initialPage ,super.key});

  final Testimonial listData;
  final List<Testimonial> list;
  final int initialPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidget,
      child: InkWell(onTap: (){TestimonialDetails.start(listData.name,list,initialPage);},child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: .5, color: MyColors.kColorGrey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {TestimonialDetails.start(listData.name,list,initialPage);},
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
                        "${Constant.baseUrl}/${listData.img}")),
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
                      child: Text(listData.degination,
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
                  ],
                )),
          ],
        ),
      ),),
    );
  }

  Widget get header {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 10),
      child: Text(
          maxLines: 1,
          listData.name,
          style: TextStyles.headingTexStyle(
              color: MyColors.themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat')),
    );
  }

  void openFilterDialog() async {
    List<User> userList = [
      User(name: "Jon", avatar: ""),
      User(name: "Lindsey ", avatar: ""),
      User(name: "Valarie ", avatar: ""),
      User(name: "Elyse ", avatar: ""),
      User(name: "Ethel ", avatar: ""),
      User(name: "Emelyan ", avatar: ""),
      User(name: "Catherine ", avatar: ""),
      User(name: "Stepanida  ", avatar: ""),
      User(name: "Carolina ", avatar: ""),
      User(name: "Nail  ", avatar: ""),
      User(name: "Kamil ", avatar: ""),
      User(name: "Mariana ", avatar: ""),
      User(name: "Katerina ", avatar: ""),
    ];

    List<User> selectedUserList = [];
    await FilterListDialog.display<User>(
      Get.context!,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        selectedUserList = List.from(list!);

        Get.back();
      },
    );
  }
}
