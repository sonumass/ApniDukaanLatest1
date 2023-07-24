import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/home/banner.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({Key? key, required this.bannerList}) : super(key: key);
  final List<BannerData> bannerList;

  @override
  State<BannerCarousel> createState() => _CarouselState();
}

class _CarouselState extends State<BannerCarousel> {
  late PageController _pageController;

  int activePage = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0, initialPage: 0);
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (activePage == widget.bannerList.length - 1) {
        end = true;
      } else if (activePage == 0) {
        end = false;
      }

      if (end == false) {
        activePage++;
      } else {
        activePage--;
      }
      _pageController.animateToPage(
        activePage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageList = <String>[];
    for (int i = 0; i <= widget.bannerList.length - 1; i++) {
      imageList.add("${Constant.baseUrl}${widget.bannerList[i].img}");
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            height: 150,
            child: PageView.builder(
                itemCount: imageList.length,
                dragStartBehavior: DragStartBehavior.start,
                reverse: false,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == activePage;

                  return slider(
                      imageList, pagePosition, active, widget.bannerList);
                }),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(imageList.length, activePage))
        ],
      ),
    );
  }
}

InkWell slider(
    List<String> topdeal, pagePosition, active, List<BannerData> bannerList) {
  double margin = active ? 2 : 4;
  String imageUrl = topdeal[pagePosition];

  return InkWell(
    child: roundedCardForImage(imageUrl, margin),
    onTap: () {
      if (bannerList[pagePosition].urlLink.isNotEmpty) {
        launchUrl(Uri.parse(bannerList[pagePosition].urlLink));
      }
    },
  );
}

Widget roundedCardForImage(String imageUrl, double margin) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imageUrl),
        ),
      ),
    ),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 100,
        height: 100,
        child: widget,
      );
    },
    child: InkWell(
      child: Image.network(images[pagePosition]),
      onTap: () {},
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 5,
      height: 5,
      decoration: BoxDecoration(
          color: currentIndex == index ? MyColors.appColor : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
