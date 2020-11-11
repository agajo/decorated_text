/// A package to decorate your text easily.
library decorated_text;

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// A Widget to decorate your text.
///
/// ```dart
/// DecoratedText(
///   'Decorated Text',
///   borderColor: Colors.amber,
///   borderWidth: 3,
///   fontSize: 40,
///   fontWeight: FontWeight.w800,
///   shadows: [
///     Shadow(
///         color: Colors.black, blurRadius: 4, offset: Offset(4, 4))
///   ],
///   fillGradient: LinearGradient(colors: [Colors.blue, Colors.red]),
/// )
/// ```
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

  /// Your text to be decorated.
  final String text;

  /// Font size.
  final double fontSize;

  /// Border width.
  final double borderWidth;

  /// Gradient to fill your text. Don't set this with fillColor.
  final Gradient fillGradient;

  /// Color to fill your text. Don't set this with fillGradient.
  final Color fillColor;

  /// Font weight.
  final FontWeight fontWeight;

  /// Border color.
  final Color borderColor;

  /// Shadows.
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

/// A Widget to decorate your text with Google Fonts.
///
/// ```dart
/// DecoratedGoogleFontText(
///   'Decorated Google Font',
///   fontMethod: GoogleFonts.rancho, // NG: GoogleFonts.rancho()
///   fontSize: 40,
///   fontWeight: FontWeight.w800,
///   borderWidth: 1.5,
///   borderColor: Colors.yellow[800],
///   shadows: const [
///     Shadow(
///         color: Colors.black, blurRadius: 4, offset: Offset(4, 4))
///   ],
///   fillGradient: LinearGradient(
///     begin: Alignment.topCenter,
///     end: Alignment.bottomCenter,
///     stops: const [0.2, 0.55, 0.55, 0.75],
///     colors: [
///       Colors.white,
///       Colors.yellow[500],
///       Colors.yellow[800],
///       Colors.yellow[500]
///     ],
///   ),
/// )
/// ```
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

  /// Pass the static method of the google_fonts package.
  /// Do not write "()".
  final GoogleFontStaticMethod fontMethod;

  /// Your text to be decorated.
  final String text;

  /// Font size.
  final double fontSize;

  /// Border width.
  final double borderWidth;

  /// Gradient to fill your text. Don't set this with fillColor.
  final Gradient fillGradient;

  /// Color to fill your text. Don't set this with fillGradient.
  final Color fillColor;

  /// Font weight.
  final FontWeight fontWeight;

  /// Border color.
  final Color borderColor;

  /// Shadows.
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

/// A type that represents the static methods of the google_fonts package.
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

/// GoogleFontStaticMethod for passing to fontMethod if you don't use the google_fonts package.
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
