TBColor
=======

`TBColor` is an ARC-compatible `CGColor`/`CGColorRef` wrapper class. It holds a `CGColorRef` and releases it when deallocated, that's it.

iOS developers have `UIColor` which does the same thing. `TBColor` is supposed to partially substitute `UIColor` on OS X (until Apple provides something better).

There are some convenience constructors, see below.

### Color Space

TBColor uses ColorSync Generic RGB color space (well, actually, Quartz does). See [this][so1] StackOverflow question (and answer) for advice on how to synchronize colors in Photoshop and your application.

Life Span
---------

Underlying CGColorRef lives for as long as it's owning TBColor instance. Doing this would be a bad idea:

```objc 
    CGColorRef makeMeAColor() {
        TBColor *willProbablyDieSoon = [TBColor fromRGB24:0x336699].CGColor;
        return willProbablyDieSoon.CGColor; // WRONG!
    }
```

If you absolutely must pass colors around, pass a TBColor instance instead:

```objc
    TBColor *makeMeAColor() {
        return [TBColor fromRGB24:0x336699]; // Okay.
    }

    // ...

    CALayer *coloredLayer = [CALayer layer];
    coloredLayer.backgroundColor = makeMeAColor().CGColor;
```

Usage
-----

`TBColor`'s `CGColor` is a read-only property. It contains `CGColorRef` for the color.

In a similar way `CGColorSpace` represents receiver's color space.

### Construction

Generic RGB from CGFloats:
```objc
    TBColor *theColor = [TBColor R:0.3f G:0.5f B:.12f];
    CGContextSetFillColorWithColor(ctx, theColor.CGColor);
```
or
```objc
    CGContextSetFillColorWithColor(ctx, [TBColor R:0.3 G:0.5 B:.12].CGColor);
```

Generic gray:
```objc
    TBColor *theColor = [TBColor gray:0.35];
```
RGB and gray with alpha: 
```objc
    TBColor *semiYellow = [TBColor R:1.0 G:0.8 B:0.0 A:0.45];
    TBColor *semiGray = [TBColor gray:0.8 alpha:0.4];
```
24-bit RGB:
```objc
    TBColor *twitterColor = [TBColor fromRGB24:0x9AE4E8]; // http://www.colourlovers.com/color/9AE4E8/twitter
```
32-bit ARGB:
```objc
    TBColor *semiTransparentPurple = [TBColor fromARGB32:0x7FEE00FF];
```
Pattern image:
```objc 
    self.layer.backgroundColor = [TBColor withPattern:[NSImage imageNamed:@"NSLinenBackgroundPattern"]].CGColor;
```

Predefined colors:
```objc
    textLayer.backgroundColor = [TBColor white].CGColor;
    consoleLayer.backgroundColor = [TBColor black].CGColor;
    redLayer.backgroundColor = [TBColor red].CGColor;
    greenLayer.backgroundColor = [TBColor green].CGColor;
    blueLayer.backgroundColor = [TBColor blue].CGColor;
```
License
-------

Do [what the fuck you want to][WTFPL].

[WTFPL]: http://sam.zoy.org/wtfpl/
[so1]: http://stackoverflow.com/questions/3146739/color-differences-between-cocoa-and-photoshop

