library decorated_text;

import 'dart:ui';

import 'package:flutter/material.dart';

class DecoratedText extends StatelessWidget {
  const DecoratedText(
    this.text, {
    this.fontSize,
    this.borderWidth,
    this.fillGradient,
    this.fillColor,
    this.fontWeight,
    this.borderColor,
    this.shadows,
  });
  final String text;
  final double fontSize;
  final double borderWidth;
  final Gradient fillGradient;
  final Color fillColor;
  final FontWeight fontWeight;
  final Color borderColor;
  final List<Shadow> shadows;

  @override
  Widget build(BuildContext context) {
    return DecoratedGoogleFontText(
      text,
      fontMethod: _defaultFontMethod,
      fontSize: fontSize,
      borderWidth: borderWidth,
      fillGradient: fillGradient,
      fillColor: fillColor,
      fontWeight: fontWeight,
      borderColor: borderColor,
      shadows: shadows,
    );
  }
}

class DecoratedGoogleFontText extends StatefulWidget {
  const DecoratedGoogleFontText(
    this.text, {
    @required this.fontMethod,
    this.fontSize,
    this.borderWidth,
    this.fillGradient,
    this.fillColor,
    this.fontWeight,
    this.borderColor,
    this.shadows,
  });
  final GoogleFontStaticMethod fontMethod;
  final String text;
  final double fontSize;
  final double borderWidth;
  final Gradient fillGradient;
  final Color fillColor;
  final FontWeight fontWeight;
  final Color borderColor;
  final List<Shadow> shadows;

  @override
  _DecoratedGoogleFontTextState createState() =>
      _DecoratedGoogleFontTextState();
}

class _DecoratedGoogleFontTextState extends State<DecoratedGoogleFontText> {
  final GlobalKey _textGlobalKey = GlobalKey();
  Rect _rect = Rect.zero;

  @override
  Widget build(BuildContext context) {
    if (widget.fillColor != null && widget.fillGradient != null) {
      throw StateError('You cannot set both fillColor and fillGradient.');
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final textRenderBox =
          _textGlobalKey.currentContext.findRenderObject() as RenderBox;
      assert(textRenderBox.hasSize);
      final offset = textRenderBox.localToGlobal(Offset.zero);
      final size = textRenderBox.size;
      final textRect =
          Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
      if (_rect != textRect) {
        setState(() {
          _rect = textRect;
        });
      }
    });
    return Stack(
      children: [
        if (widget.borderWidth != null)
          Text(
            widget.text,
            style: widget.fontMethod(
                fontWeight: widget.fontWeight ?? FontWeight.w500,
                fontSize: widget.fontSize ?? 20,
                shadows: widget.shadows,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  // Double the thickness beforehand, as the inner half will be filled in and disappear.
                  ..strokeWidth = widget.borderWidth * 2
                  ..color = widget.borderColor ?? Colors.black),
          ),
        Text(
          widget.text,
          key: _textGlobalKey,
          style: widget.fontMethod(
            fontWeight: widget.fontWeight ?? FontWeight.w500,
            fontSize: widget.fontSize ?? 20,
            foreground: widget.fillColor != null
                ? (Paint()..color = widget.fillColor)
                : widget.fillGradient != null
                    ? (Paint()
                      ..shader = widget.fillGradient.createShader(_rect))
                    : (Paint()..color = Colors.black),
          ),
        ),
      ],
    );
  }
}

typedef GoogleFontStaticMethod = TextStyle Function(
    {TextStyle textStyle,
    Color color,
    Color backgroundColor,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    List<Shadow> shadows,
    List<FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness});

TextStyle _defaultFontMethod(
    {TextStyle textStyle,
    Color color,
    Color backgroundColor,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    List<Shadow> shadows,
    List<FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness}) {
  return (textStyle ?? const TextStyle()).copyWith(
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );
}
