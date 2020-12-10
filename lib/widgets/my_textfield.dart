import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:monedero/util/sizes.dart';

class TxtCodika extends StatefulWidget {
  final String label;
  final String text;
  final bool isBorder;
  final bool isDense;
  final bool isFillColor;
  final bool isObscureText;
  final EdgeInsets txtPaddingAll;
  final double txtRadiusBorder;
  final TextEditingController txtController;
  final dynamic prefixIconF;
  final double prefixIconFZise;
  final IconData suffixIconF;
  final Widget suffixWi;
  final double suffixIconFZise;
  final Color colorIcon;
  final Stream txtStream;
  final Function onChangedStream;
  final Function(String) onChangedText;
  final Function txtonTap;
  final TextInputType inputType;
  final FocusNode txtfocusNode;
  final EdgeInsets containerPadding;
  final int lineOnText;
  final String maskString;
  final TextStyle textStyle;
  final TextAlign textAling;
  final Color fillColor;
  final Widget preffix;
  final int maxLines;

  const TxtCodika({
    this.label,
    this.text,
    this.isBorder = false,
    this.isDense = false,
    this.txtPaddingAll = const EdgeInsets.all(0),
    this.containerPadding = const EdgeInsets.all(6),
    this.txtRadiusBorder = 10.0,
    this.txtController,
    this.prefixIconF,
    this.prefixIconFZise = 20,
    this.suffixIconFZise = 20,
    this.suffixIconF,
    this.colorIcon = Colors.black,
    this.isFillColor = true,
    this.txtStream,
    this.onChangedStream,
    this.inputType = TextInputType.text,
    this.isObscureText = false,
    this.txtonTap,
    this.onChangedText,
    this.lineOnText = 1,
    this.txtfocusNode,
    this.suffixWi,
    this.maskString = '',
    this.textStyle,
    this.textAling = TextAlign.start,
    this.fillColor,
    this.preffix,
    this.maxLines,
  });

  @override
  _TxtCodika createState() => _TxtCodika();
}

class _TxtCodika extends State<TxtCodika> {
  bool _focus = false;
  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: widget.maskString.toString(), filter: {"#": RegExp(r'[0-9]')});
    return widget.txtStream != null
        ? StreamBuilder(
            stream: widget.txtStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Padding(
                  padding: widget.txtPaddingAll,
                  child: TextField(
                    maxLines: widget.maxLines,
                    textAlign: widget.textAling,
                    inputFormatters:
                        widget.maskString != '' ? [maskFormatter] : [],
                    // maxLines: widget.lineOnText,
                    controller: widget.txtController != null
                        ? widget.txtController
                        : null,
                    keyboardType: widget.inputType,
                    decoration:
                        _decoracion(widget.isBorder, snapshot.error, _focus),
                    onChanged: widget.onChangedStream,
                    onTap: widget.txtonTap,
                    style: (widget.textStyle == null)
                        ? textos(
                            ctn: context, color: Theme.of(context).primaryColor)
                        : widget.textStyle,
                    obscureText: widget.isObscureText,
                  )
                  // focusNode: widget.txtfocusNode),
                  );
            },
          )
        : Padding(
            padding: widget.txtPaddingAll,
            child: Focus(
              child: TextField(
                maxLines: widget.maxLines,
                textAlign: widget.textAling,
                inputFormatters: [maskFormatter],
                // maxLines: widget.lineOnText,
                controller:
                    widget.txtController != null ? widget.txtController : null,
                keyboardType: widget.inputType,
                decoration: _decoracion(widget.isBorder, null, _focus),
                obscureText: widget.isObscureText,
                //bloc.changeEmail,
                style: (widget.textStyle == null)
                    ? textos(
                        ctn: context, color: Theme.of(context).primaryColor)
                    : widget.textStyle,
                onTap: widget.txtonTap,
                onChanged: widget.onChangedText,
              ),
              onFocusChange: (value) {
                setState(() {
                  _focus = value;
                });
              },
            ),
          );
  }

  OutlineInputBorder _customBorder(bool isBorder, bool isFocus, Color color) {
    return isBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.txtRadiusBorder),
            borderSide: BorderSide(
              width: 0.5,
              color: color,
            ))
        : OutlineInputBorder(
            //borderRadius: BorderRadius.circular(txtRadiusBorder),
            borderSide: BorderSide(
            width: 0.5,
            color: color,
          ));
  }

  InputDecoration _decoracion(
      bool isBoder, String errorMessage, bool isFillColor) {
    final streamEmpty = false;
    final focus = widget.txtStream != null
        ? (isFillColor && !streamEmpty)
        : (!isFillColor && widget.txtController.text.isEmpty);

    //print(_b);

    return widget.isBorder
        ? InputDecoration(
            labelText: widget.text == null ? null : widget.text,
            contentPadding: widget.containerPadding,
            isDense: widget.isDense,
            filled: focus,
            fillColor: isFillColor
                ? Colors.transparent
                : widget.fillColor, //Colors.amberAccent,
            border:
                _customBorder(isBoder, focus, Theme.of(context).primaryColor),
            enabledBorder:
                _customBorder(isBoder, focus, Theme.of(context).primaryColor),
            focusedBorder:
                _customBorder(isBoder, focus, Theme.of(context).primaryColor),
            focusColor: Colors.white,
            errorText: errorMessage,
            prefixIcon: widget.prefixIconF != null
                ? Icon(
                    widget.prefixIconF,
                    size: widget.prefixIconFZise,
                    color: widget.colorIcon,
                  )
                : widget.prefixIconF == null
                    ? widget.preffix
                    : null,
            suffixIcon: widget.suffixIconF != null
                ? Icon(
                    widget.suffixIconF,
                    size: widget.suffixIconFZise,
                    color: widget.colorIcon,
                  )
                : widget.suffixWi != null
                    ? widget.suffixWi
                    : null,
            hintText: widget.label,
            // labelText: widget.label,
          )
        : InputDecoration(
            labelText: widget.text == null ? null : widget.text,
            contentPadding: widget.containerPadding,
            isDense: widget.isDense,
            errorText: errorMessage,
            prefixIcon: widget.prefixIconF != null
                ? Icon(
                    widget.prefixIconF,
                    size: widget.prefixIconFZise,
                    color: widget.colorIcon,
                  )
                : widget.prefixIconF == null
                    ? widget.preffix
                    : null,
            suffixIcon: widget.suffixIconF != null
                ? Icon(
                    widget.suffixIconF,
                    size: widget.suffixIconFZise,
                    color: widget.colorIcon,
                  )
                : widget.suffixWi != null
                    ? widget.suffixWi
                    : null,
            focusColor: Colors.white,
            hintText: widget.label,
            // labelText: widget.label,
          );
  }
}
