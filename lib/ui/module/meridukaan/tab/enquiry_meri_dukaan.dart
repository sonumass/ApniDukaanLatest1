import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mcsofttech/utils/palette.dart';

import '../../../commonwidget/text_style.dart';

class EnquiryStatefulWidget extends StatefulWidget {
  const EnquiryStatefulWidget({Key? key}) : super(key: key);

  @override
  State<EnquiryStatefulWidget> createState() => _EnquiryStatefulWidgetState();
}

class _EnquiryStatefulWidgetState extends State<EnquiryStatefulWidget> {
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
              children: [aboutUsText, divider, feedbackForm],
            ))),
      ),
    );
  }

  Widget get aboutUsText {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          "Contact Us",
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

  Widget get feedbackForm {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Palette.kColorWhite,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                debugPrint(rating.toString());
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
            border: Border.all(width: 1, color: Colors.green),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your name',
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
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your phone',
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
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your email',
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
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your Message',
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
          padding: const EdgeInsets.only(right: 10, top: 20, bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                "Send",
                style: TextStyles.headingTexStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
