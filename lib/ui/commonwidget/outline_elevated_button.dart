import 'package:flutter/material.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/utils/palette.dart';

class OutLineElevatedBtn extends StatefulWidget {
  final String _text;
  final Widget? icon;
  final VoidCallback? _onClicked;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double borderRadius;

  const OutLineElevatedBtn(this._text, this._onClicked,
      {this.icon,
      this.buttonStyle,
      this.textStyle,
      this.borderRadius = 8.0,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OutLineElevatedBtnState();
  }
}

class _OutLineElevatedBtnState extends State<OutLineElevatedBtn> {
  @override
  void didUpdateWidget(covariant OutLineElevatedBtn oldWidget) {
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
              fontSize: 14,
              color: MyColors.themeColor,
              fontWeight: FontWeight.w700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  ButtonStyle get buttonStyle {
    return widget.buttonStyle ??
        ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 1, color: MyColors.themeColor),
                    borderRadius: BorderRadius.circular(widget.borderRadius))),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> state) {
              if (state.contains(MaterialState.pressed)) {
                return Palette.kColorWhite;
              } else if (state.contains(MaterialState.disabled)) {
                return Palette.kColorWhite;
              }
              return Palette.kColorWhite;
            }));
  }
}
