//
//  TBColor.m
//
//  Created by Zoreslav Khimich on 5/26/12.
//  Copyright (c) 2012 Zoreslav Khimich <zoreslav@me.com>
//
//  Licensed under WTFPL (http://sam.zoy.org/wtfpl/)

#import "TBColor.h"
@interface TBColor () {
    CGColorRef _CGColor;
}
@end

@implementation TBColor
@synthesize CGColor = _CGColor;

- (id)initWithGenericGray:(CGFloat)gray alpha:(CGFloat)alpha {
    self = [super init];
    if (self) {
        _CGColor = CGColorCreateGenericGray(gray, alpha);
    }
    return self;
}

- (id)initWithGenericRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha  {
    self = [super init];
    if (self) {
        _CGColor = CGColorCreateGenericRGB(red, green, blue, alpha);
    }
    return self;
}

- (void)dealloc {
    CGColorRelease(_CGColor);
}

- (CGColorRef)ref {
    return _CGColor;
}

+ (TBColor*)gray:(CGFloat)gray alpha:(CGFloat)alpha {
    return [[TBColor alloc] initWithGenericGray:gray alpha:alpha];
}

+ (TBColor*)gray:(CGFloat)gray {
    return [TBColor gray:gray alpha:1.f];
}

+ (TBColor*)black {
    static TBColor* blackColor = nil;
    if (!blackColor) {
        blackColor = [TBColor gray:0.f];
    }
    return blackColor;
}

+ (TBColor*)white {
    static TBColor* whiteColor = nil;
    if (!whiteColor) {
        whiteColor = [TBColor gray:1.f];
    }
    return whiteColor;
}

+ (TBColor*)R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [[TBColor alloc]initWithGenericRed:red green:green blue:blue alpha:alpha];
}

+ (TBColor*)R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue {
    return [TBColor R:red G:green B:blue A:1.f];
}

+ (TBColor*)fromARGB32:(uint32_t)argb32 {
    const unsigned char a8 = (argb32 & 0xFF000000) >> 24;
    const unsigned char r8 = (argb32 & 0x00FF0000) >> 16;
    const unsigned char g8 = (argb32 & 0x0000FF00) >> 8;
    const unsigned char b8 = (argb32 & 0x000000FF);
    return [TBColor R: (CGFloat)(r8)/255.f G:(CGFloat)(g8)/255.f B:(CGFloat)(b8)/255.f A:(CGFloat)(a8)/255.f];
}

+ (TBColor*)fromRGB24:(uint32_t)rgb24 {
    return [TBColor fromARGB32:0xFF000000 | rgb24];
}

+ (TBColor*)red {
    static TBColor* redColor = nil;
    if (!redColor) {
        redColor = [TBColor fromRGB24:0xFF0000];
    }
    return redColor;
}

+ (TBColor*)green {
    static TBColor*greenColor = nil;
    if (!greenColor) {
        greenColor = [TBColor fromRGB24:0x00FF00];
    }
    return greenColor;
}

+ (TBColor*)blue {
    static TBColor* blueColor = nil;
    if (!blueColor) {
        blueColor = [TBColor fromRGB24:0x0000FF];
    }
    return blueColor;
}


@end
