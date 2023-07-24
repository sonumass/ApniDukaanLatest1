import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import '../../../../../models/product_filter_model.dart';
import '../../../commonwidget/text_style.dart';
import '../../videos/VideoNewsDetail.dart';

class VideoCard extends BaseStateLessWidget {
  const VideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidget,
      child: InkWell(
        onTap: () {
          VideoNewsDetail.start("NATKA1RF6qE","");
        },
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
                onTap: () {
                  VideoNewsDetail.start("iLnmTe5Q2Qw","");
                },
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
                              "${Constant.baseUrl}/img/product/noaImg2.png")),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  header,
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Text(
                        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
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
          "Category",
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
