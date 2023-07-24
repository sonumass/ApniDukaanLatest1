import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../models/newandvideo/YoutubeModel.dart';
import '../../../../models/product_filter_model.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/common_util.dart';
import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';
import '../widget/new_widget_card.dart';
import '../widget/video_widget.dart';

class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({Key? key}) : super(key: key);

  @override
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  static final List<User> _animals = [
    User(avatar: "", name: "Lion1"),
    User(avatar: "", name: "Lion2"),
    User(avatar: "", name: "Lion3"),
    User(avatar: "", name: "Lion4"),
    User(avatar: "", name: "Lion5"),
  ];
  bool filter = false;
  final _items = _animals
      .map((animal) => MultiSelectItem<User>(animal, animal.name ?? ""))
      .toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.coloPageBg,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              allNews("All News"),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Wrap(
                  spacing: 5,
                  children: newsList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get newsList {
    List<Widget> list = [];
    for (int i = 0; i <= 8; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: VideoCard(),
          )));
      /*if ((i + 1) % 6 == 0) {
        list.add(SizedBox(
          height: 150,
          child: AdWidget(
            ad: AdHelper.getBannerAd()..load(),
            key: UniqueKey(),
          ),
        ));
      }*/
    }
    return list;
  }

  Widget allNews(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyles.headingTexStyle(
              color: Palette.colorTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          InkWell(
            onTap: () {
              bottomSheet;
            },
            child: SvgPicture.asset("assets/svg/icon_filter.svg"),
          ),
        ],
      ),
    );
  }

  get bottomSheet {
    final List<User> animals = [
      User(avatar: "", name: "Lion"),
      User(avatar: "", name: "Lion2"),
      User(avatar: "", name: "Lion3"),
      User(avatar: "", name: "Lion4"),
      User(avatar: "", name: "Lion5"),
    ];
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
          side: BorderSide(color: Colors.white)),
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          selectedColor: MyColors.themeColor,
          items: _items,
          initialValue: animals,
          onConfirm: (values) {
            Common.showToast(values.toString());
          },
          maxChildSize: 0.8,
          cancelText: cancel,
          confirmText: apply,
        );
      },
    );
  }

  Text get cancel {
    return Text(
      "Reset",
      style: TextStyles.headingTexStyle(
        color: MyColors.themeColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Text get apply {
    return const Text(
      "Apply",
      style: TextStyle(
        color: MyColors.themeColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Montserrat',
      ),
    );
  }
}
