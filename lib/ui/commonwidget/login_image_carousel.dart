import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mcsofttech/theme/my_theme.dart';

class LoginCarousel extends StatefulWidget {
  LoginCarousel({Key? key}) : super(key: key);

  @override
  State<LoginCarousel> createState() => _CarouselState();
}

class _CarouselState extends State<LoginCarousel> {
  late PageController _pageController;
  int activePage = 0;

  bool end = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0, initialPage: 0);

    Future.delayed(Duration.zero, () async {

      Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (activePage == 2) {
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
      })
      ;
    });


  }

  @override
  Widget build(BuildContext context) {
    final List<String> bannerList = [
      "assets/png/login_1.jpg",
      "assets/png/login_2.jpg",
      "assets/png/login3.jpg"
    ];
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
              itemCount: bannerList.length,
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

                return slider(bannerList, pagePosition, active, context);
              }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(bannerList.length, activePage)),
          ),
        )
      ],
    );
  }
}

Container slider(
    List<String> topdeal, pagePosition, active, BuildContext context) {
  double margin = active ? 2 : 4;
  String imageUrl = topdeal[pagePosition];

  return Container(
    height: 120.0,
    width: 120.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imageUrl),
        fit: BoxFit.fill,
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
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? MyColors.kColorBlack : Colors.white,
          shape: BoxShape.circle),
    );
  });
}
