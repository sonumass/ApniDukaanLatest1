import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/module/product/product_detail.dart';

import '../../../../../models/product_filter_model.dart';
import '../../../../../utils/palette.dart';
import '../../../../commonwidget/text_style.dart';

class SubCatProductCardd extends BaseStateLessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: favouriteRow(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  ProductDetail.start("Vegetable");
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    "https://www.pngplay.com/wp-content/uploads/1/Tractor-PNG-Images-HD.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              productName,
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  children: [
                    Text("\u{20B9} 500000",
                        style: TextStyles.headingTexStyle(
                            fontSize: 12,
                            color: Palette.appColor,
                            fontFamily: "assets/font/Oswald-Regular.ttf")),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("\u{20B9} 500000",
                        style: TextStyles.headingTexStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Palette.kColorRed,
                            fontFamily: "assets/font/Oswald-Regular.ttf"))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get productName {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text("Tractor",
          style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontFamily: "assets/font/Oswald-Bold.ttf")),
    );
  }

  Widget favouriteRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
              color: Palette.appColor,
              margin: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  " Featured",
                  style: TextStyle(color: Palette.colorWhite),
                ),
              )),
          const Icon(
            Icons.favorite,
            color: Palette.kColorRed,
          )
        ],
      ),
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
