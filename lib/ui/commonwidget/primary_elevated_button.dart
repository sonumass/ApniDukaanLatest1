import 'package:flutter/material.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/utils/palette.dart';

class PrimaryElevatedBtn extends StatefulWidget {
  final String _text;
  final Widget? icon;
  final VoidCallback? _onClicked;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double borderRadius;

  const PrimaryElevatedBtn(this._text, this._onClicked,
      {this.icon,
      this.buttonStyle,
      this.textStyle,
      this.borderRadius = 8.0,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrimaryElevatedBtnState();
  }
}

class _PrimaryElevatedBtnState extends State<PrimaryElevatedBtn> {
  @override
  void didUpdateWidget(covariant PrimaryElevatedBtn oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget._onClicked,
      child: _text,
      style: buttonStyle,
    );
  }

  Widget get _text {
    return Text(
      widget._text,
      style: widget.textStyle ??
          const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  ButtonStyle get buttonStyle {
    return widget.buttonStyle ??
        ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius))),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> state) {
              if (state.contains(MaterialState.pressed)) {
                return MyColors.themeColor;
              } else if (state.contains(MaterialState.disabled)) {
                return MyColors.themeColor;
              }
              return MyColors.themeColor;
            }));
  }
}
