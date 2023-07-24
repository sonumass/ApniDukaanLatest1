import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../../commonwidget/text_style.dart';

class FeedbackStatefulWidget extends StatefulWidget {
  const FeedbackStatefulWidget({Key? key}) : super(key: key);

  @override
  State<FeedbackStatefulWidget> createState() => _FeedbackStatefulWidgetState();
}

class _FeedbackStatefulWidgetState extends State<FeedbackStatefulWidget> {
  double width = 0.0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: double.maxFinite,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
            height: double.maxFinite,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
              children: [aboutUsText, divider, loadMoreFeedback, feedbackForm],
            ))),
      ),
    );
  }

  Widget get aboutUsText {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          "REVIEW & RATING",
          style: TextStyles.headingTexStyle(color: Colors.green),
        ),
      ),
    );
  }

  Widget get divider {
    return const SizedBox(
      width: 140,
      child: Divider(color: Colors.red, height: 20.0, thickness: 5),
    );
  }

  Widget get loadMoreFeedback {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Load More Feedback",
              style: TextStyles.headingTexStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget get feedbackForm {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Palette.kColorLightBGGreen,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Give feedback",
                style: TextStyles.headingTexStyle(color: Colors.black),
              ),
              ratingBar(),
              nameFiled,
              mobileFiled,
              emailFiled,
              feedbackFiled,
              giveFeedBackButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget ratingBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget get nameFiled {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your Name',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get mobileFiled {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your mobile',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get emailFiled {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your email',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get feedbackFiled {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your Feedback',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get giveFeedBackButton {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Give Feedback",
                style: TextStyles.headingTexStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
