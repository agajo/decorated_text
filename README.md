# decorated_text

![スクリーンショット 2020-11-10 16 45 05](https://user-images.githubusercontent.com/12369062/98644768-525df580-2374-11eb-90bb-c03d6c9b3b4d.png)

Decorates your text. You can add gradients inside and color in the outline. You can also use GoogleFonts.

Unlike other similar methods, you don't need to specify a position for Gradient.

## What you can do with this package

You can easily add borders, gradients, and shadows to Text. These are harder than you might think to do with Flutter's features alone.
You don't have to go through the hassle of getting the Text bound and passing it to createShader.
You can apply this to GoogleFont as well. You can also use IDE completion when choosing a font name.
It follows transforms such as scaling and rotating.

## Usage


```dart
DecoratedText(
  'Decorated Text',
  borderColor: Colors.amber,
  borderWidth: 3,
  fontSize: 40,
  fontWeight: FontWeight.w800,
  shadows: [
    Shadow(
        color: Colors.black, blurRadius: 4, offset: Offset(4, 4))
  ],
  fillGradient: LinearGradient(colors: [Colors.blue, Colors.red]),
)
```

### with GoogleFonts

```dart
DecoratedGoogleFontText(
  'Decorated Google Font',
  fontMethod: GoogleFonts.rancho,
  fontSize: 40,
  fontWeight: FontWeight.w800,
  borderWidth: 1.5,
  borderColor: Colors.yellow[800],
  shadows: const [
    Shadow(
        color: Colors.black, blurRadius: 4, offset: Offset(4, 4))
  ],
  fillGradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.2, 0.55, 0.55, 0.75],
    colors: [
      Colors.white,
      Colors.yellow[500],
      Colors.yellow[800],
      Colors.yellow[500]
    ],
  ),
)
```