library decorated_text;

import 'dart:ui' as ui;

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

class DecoratedGoogleFontText extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (fillColor != null && fillGradient != null) {
      throw StateError('You cannot set both fillColor and fillGradient.');
    }

    return Stack(
      children: [
        if (borderWidth != null)
          // Some fonts overflow the bound, so padding is added to paint it.
          Padding(
            padding:
                EdgeInsets.only(right: fontSize != null ? fontSize / 2 : 10),
            child: Text(
              text,
              style: fontMethod(
                  fontWeight: fontWeight ?? FontWeight.w500,
                  fontSize: fontSize ?? 20,
                  shadows: shadows,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    // Double the thickness beforehand, as the inner half will be filled in and disappear.
                    ..strokeWidth = borderWidth * 2
                    ..color = borderColor ?? Colors.black),
            ),
          ),
        ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bound) {
            if (fillGradient != null) {
              return fillGradient.createShader(bound.expandToInclude(bound));
            } else {
              return LinearGradient(colors: [fillColor, fillColor])
                  .createShader(Rect.zero);
            }
          },
          // Some fonts overflow the bound, so padding is added to paint it.
          child: Padding(
            padding:
                EdgeInsets.only(right: fontSize != null ? fontSize / 2 : 10),
            child: Text(
              text,
              style: fontMethod(
                // Default text color is not complete black, so it's necessary to fill with true black.
                color: Colors.black,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: fontSize ?? 20,
              ),
            ),
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
    List<ui.FontFeature> fontFeatures,
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
    List<ui.FontFeature> fontFeatures,
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
