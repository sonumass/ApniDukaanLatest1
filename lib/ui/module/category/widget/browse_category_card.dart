import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';

import '../../../../models/product_filter_model.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';
import '../subcategory/subcategory_page.dart';

class BrowseCategoryCard extends BaseStateLessWidget {
  List<String> imageUrl = [
    "https://png.pngtree.com/png-vector/20190130/ourmid/pngtree-farm-car-farm-tool-red-design-toolsfarming-car-png-image_582166.jpg",
    "https://png.pngtree.com/element_our/20190529/ourmid/pngtree-snacks-dried-fruit-nuts-melon-seeds-image_1228711.jpg",
    "https://e7.pngegg.com/pngimages/447/384/png-clipart-vegetables-herbs-vegetarian-cuisine-vegetable-natural-foods-leaf-vegetable.png",
    "https://png.pngtree.com/png-vector/20190130/ourmid/pngtree-farm-car-farm-tool-red-design-toolsfarming-car-png-image_582166.jpg"
  ];

  BrowseCategoryCard(this.user);

  final User user;

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
              Expanded(
                child: InkWell(
                  onTap: () {
                    SubCagetoryPage.start("Sub Category");
                  },
                  child: Image.network(
                    imageUrl[0],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Text(user.name!,
                    maxLines: 1,
                    style: TextStyles.headingTexStyle(
                        color: Palette.colorTextBlack,
                        fontFamily: "assets/font/Oswald-Regular.ttf")),
              ),
              const SizedBox(
                height: 5,
              ),
              /*productName,
              const SizedBox(
                height: 5,
              ),*/
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
          style: TextStyles.labelTextStyle(
              color: Palette.colorTextBlack,
              fontFamily: "assets/font/Oswald-Regular.ttf")),
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
