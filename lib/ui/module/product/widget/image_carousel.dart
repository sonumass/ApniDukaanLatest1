import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mcsofttech/theme/my_theme.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key, required this.imageList}) : super(key: key);
  final List<String> imageList;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  int activePage = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 1.0, initialPage: 0);
    /*Timer.periodic(const Duration(seconds: 2), (Timer timer) {
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
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: PageView.builder(
                itemCount: widget.imageList.length,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == activePage;
                  return slider(widget.imageList, pagePosition, active);
                }),
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicators(widget.imageList.length, activePage)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

InkWell slider(List<String> topdeal, pagePosition, active) {
  double margin = active ? 2 : 4;
  String imageUrl = topdeal[pagePosition];

  return InkWell(
    child: roundedCardForImage(imageUrl, margin),
    onTap: () {},
  );
}

Widget roundedCardForImage(String imageUrl, double margin) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0.0),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(imageUrl),
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
          color: currentIndex == index ? MyColors.kColorRed : Colors.white,
          shape: BoxShape.circle),
    );
  });
}
