import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcsofttech/ui/module/profile/profile_page.dart';

import '../../../../utils/palette.dart';
import '../../../commonwidget/text_style.dart';
import '../../profile/widget/profile_widget.dart';
import '../home.dart';

class Account extends StatefulWidget {
  Account({
    Key? key,
  }) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            profileUiRow,
            const SizedBox(
              height: 20,
            ),
            const Divider(color: Colors.grey),
            const SizedBox(
              height: 5,
            ),
            helpAndSupport,
            const Divider(color: Colors.grey),
            const SizedBox(
              height: 5,
            ),
            profileWidget,
            const SizedBox(
              height: 5,
            ),
            const Divider(color: Colors.grey),
            const SizedBox(
              height: 5,
            ),
            orderWidget,
            const SizedBox(
              height: 5,
            ),
            const Divider(color: Colors.grey),
            const SizedBox(
              height: 5,
            ),
            logoutWidget,
            const SizedBox(
              height: 5,
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget get profileUiRow {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileWidget(
          imagePath:
              "https://w7.pngwing.com/pngs/754/2/png-transparent-samsung-galaxy-a8-a8-user-login-telephone-avatar-pawn-blue-angle-sphere-thumbnail.png",
          isEdit: true,
          onClicked: () async {},
        ),
        const SizedBox(
          width: 20,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: welcomeToF2df,
        )
      ],
    );
  }

  Widget get welcomeToF2df {
    return Column(children: [
      InkWell(
        onTap: () {
          Home.start();
        },
        child: SizedBox(
          height: 20,
          child: Text(
            "Welcome To F2DF",
            style: TextStyles.headingTexStyle(
                color: Palette.appColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      InkWell(
        onTap: () {
          Home.start();
        },
        child: SizedBox(
          height: 20,
          child: Text(
            "Log in to your account",
            style: TextStyles.labelTextStyle(
              color: Palette.appColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      )
    ]);
  }

  Widget get helpAndSupport {
    return InkWell(
      onTap: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.help),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Help and Support",
                    style: TextStyles.headingTexStyle(
                        color: Palette.colorTextBlack, fontSize: 15)),
                Text("Help center and legal terms",
                    style: TextStyles.labelTextStyle(
                        color: Palette.colorTextGrey, fontSize: 15))
              ],
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Palette.colorTextGrey,
          ),
        )
      ]),
    );
  }

  Widget get profileWidget {
    return InkWell(
      onTap: () {
        EditProfile.start();
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.account_circle),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Profile",
                    style: TextStyles.headingTexStyle(
                        color: Palette.colorTextBlack, fontSize: 15)),
                Text("Click here to edit profile",
                    style: TextStyles.labelTextStyle(
                        color: Palette.colorTextGrey, fontSize: 15))
              ],
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Palette.colorTextGrey,
          ),
        )
      ]),
    );
  }

  Widget get orderWidget {
    return InkWell(
      onTap: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.list),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Order History",
                    style: TextStyles.headingTexStyle(
                        color: Palette.colorTextBlack, fontSize: 15)),
                Text("Click here to check last order",
                    style: TextStyles.labelTextStyle(
                        color: Palette.colorTextGrey, fontSize: 15))
              ],
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Palette.colorTextGrey,
          ),
        )
      ]),
    );
  }

  Widget get logoutWidget {
    return InkWell(
      onTap: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.logout),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LogOut",
                    style: TextStyles.headingTexStyle(
                        color: Palette.colorTextBlack, fontSize: 15)),
                Text("Click here to Logout",
                    style: TextStyles.labelTextStyle(
                        color: Palette.colorTextGrey, fontSize: 15))
              ],
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Palette.colorTextGrey,
          ),
        )
      ]),
    );
  }
}
