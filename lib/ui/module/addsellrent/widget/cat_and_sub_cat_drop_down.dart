import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/category/CategoryCatData.dart';
import '../../../../models/category/SubCategory.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';

class CatAndSubCatDropDown extends StatefulWidget {
  const CatAndSubCatDropDown({Key? key, required this.categoryCatDataList})
      : super(key: key);
  final List<CategoryCatData> categoryCatDataList;

  @override
  _CatAndSubCatDropDownState createState() => _CatAndSubCatDropDownState();
}

class _CatAndSubCatDropDownState extends State<CatAndSubCatDropDown> {
  late CategoryCatData categoryCatData = widget.categoryCatDataList.first;

  late SubCategory subCategoryData;
  bool subCatIsEnable = false;
  List<SubCategory> subCatList = <SubCategory>[];

  @override
  Widget build(BuildContext context) {
    subCategoryData = widget.categoryCatDataList.first.subCategories!.first;
    subCatList = widget.categoryCatDataList.first.subCategories!;

    return body;
  }

  Widget get body {
    return ListView(
      padding: const EdgeInsets.only(left: 12, right: 12),
      children: [
        DropdownButton<CategoryCatData>(
          hint: const Text("Category"),
          value: categoryCatData,
          isExpanded: true,
          items: widget.categoryCatDataList.map((CategoryCatData item) {
            return DropdownMenuItem<CategoryCatData>(
                value: item, child: Text(item.categoryName));
          }).toList(),
          onChanged: (CategoryCatData? item) {
            setState(() {
              categoryCatData = item!;
              subCatList = item.subCategories!;
              subCatIsEnable = true;
            });
          },
        ),
        subCatIsEnable
            ? DropdownButton<SubCategory>(
                hint: const Text("Category"),
                value: subCategoryData,
                isExpanded: true,
                items: subCatList.map((SubCategory item) {
                  return DropdownMenuItem<SubCategory>(
                      value: item, child: Text(item.subCategoryName));
                }).toList(),
                onChanged: (SubCategory? item) {
                  setState(() {
                    subCategoryData = item!;
                  });
                },
              )
            : const SizedBox.shrink(),
      ],
    );
    /*return Column(children: [
        const SizedBox(
          height: 10,
        ),
        labelText("Category"),
        const SizedBox(
          height: 10,
        ),
        dropDownField1(),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
        const SizedBox(
          height: 10,
        ),
        labelText("SubCategory"),
        const SizedBox(
          height: 10,
        ),

        subCatIsEnable?dropDownField2(subCategoryData,subCatList):const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Palette.kColorGrey,
        ),
      ],);*/
  }

  Widget labelText(String label) {
    return Text(
      label,
      style: TextStyles.headingTexStyle(
          color: Palette.kColorBlack, fontFamily: "Oswald-Bold.ttf"),
    );
  }

  Widget dropDownField1() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Palette.colorWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey, //                   <--- border color
            width: 1.0,
          )),
      child: DropdownButton(
        isExpanded: true,
        underline: Container(),
        // Initial Value
        value: categoryCatData,

        // Down Arrow Icon
        icon: const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.keyboard_arrow_down),
        ),

        // Array list of items
        items: widget.categoryCatDataList.map((CategoryCatData items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.categoryName),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (CategoryCatData? item) {
          setState(() {
            categoryCatData = item!;
          });
          setState(() {
            subCategoryData = item!.subCategories!.first;
            subCatList = item.subCategories!;
            subCatIsEnable = true;
          });
        },
      ),
    );
  }

  Widget dropDownField2(SubCategory subCategoryData, List<SubCategory> list) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Palette.colorWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey, //                   <--- border color
            width: 1.0,
          )),
      child: subCatIsEnable
          ? dropdown(subCategoryData, list)
          : const SizedBox.shrink(),
    );
  }

  DropdownButton dropdown(SubCategory subCategoryData, List<SubCategory> list) {
    return DropdownButton(
      isExpanded: true,
      underline: Container(),
      // Initial Value
      value: subCategoryData,

      // Down Arrow Icon
      icon: const Align(
        alignment: Alignment.centerRight,
        child: Icon(Icons.keyboard_arrow_down),
      ),

      // Array list of items
      items: subCatListWidget(list),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (newValue) {
        setState(() {
          subCategoryData = newValue!;
        });
      },
    );
  }

  List<DropdownMenuItem<SubCategory>> subCatListWidget(
      List<SubCategory> subCatListt) {
    subCatListt = categoryCatData.subCategories!;
    return subCatListt.map((SubCategory items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items.subCategoryName),
      );
    }).toList();
  }
}
