import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool addOpacity;

  const Loader({
    Key? key,
    this.addOpacity = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              if (addOpacity)
                const Opacity(
                  opacity: 0.65,
                  child: ModalBarrier(dismissible: false, color: Colors.white),
                ),
              appLoader
            ],
          ),
        ));
  }

  Widget get appLoader {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20),
        child: const CircularProgressIndicator());
  }
}
