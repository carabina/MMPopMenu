//
//  UIColor+MMAdditions.m
//  Created by Joan Martin.
//  Take a look to my repos at http://github.com/vilanovi
//
// Copyright (c) 2013 Joan Martin, vilanovi@gmail.com.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "UIColor+MMAdditions.h"

#define MM_RED_MASK        0xFF0000
#define MM_GREEN_MASK      0xFF00
#define MM_BLUE_MASK       0xFF
#define MM_ALPHA_MASK      0xFF000000

#define MM_RED_SHIFT       16
#define MM_GREEN_SHIFT     8
#define MM_BLUE_SHIFT      0
#define MM_ALPHA_SHIFT     24

#define MM_COLOR_SIZE      255.0

#define MM_LUM_RED         0.2989
#define MM_LUM_GREEN       0.5870
#define MM_LUM_BLUE        0.1140

@implementation UIColor (MMAdditions)

+ (UIColor*)mm_colorWithRGBHexValue:(MMColorType)rgbValue
{
    return [UIColor mm_colorWithRGBHexValue:rgbValue andAlpha:1.0];
}

+ (UIColor*)mm_colorWithRGBHexValue:(MMColorType)rgbValue andAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((CGFloat)((rgbValue & MM_RED_MASK) >> MM_RED_SHIFT))/MM_COLOR_SIZE
                           green:((CGFloat)((rgbValue & MM_GREEN_MASK) >> MM_GREEN_SHIFT))/MM_COLOR_SIZE
                            blue:((CGFloat)((rgbValue & MM_BLUE_MASK) >> MM_BLUE_SHIFT))/MM_COLOR_SIZE
                           alpha:alpha];
}

+ (UIColor*)mm_colorWithRGBAHexValue:(MMColorType)rgbaValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbaValue & MM_RED_MASK) >> MM_RED_SHIFT))/MM_COLOR_SIZE
                           green:((CGFloat)((rgbaValue & MM_GREEN_MASK) >> MM_GREEN_SHIFT))/MM_COLOR_SIZE
                            blue:((CGFloat)((rgbaValue & MM_BLUE_MASK) >> MM_BLUE_SHIFT))/MM_COLOR_SIZE
                           alpha:((CGFloat)((rgbaValue & MM_ALPHA_MASK) >> MM_ALPHA_SHIFT))/MM_COLOR_SIZE];
}

+ (UIColor*)mm_colorWithRGBHexString:(NSString*)rgbStrValue
{
    return [UIColor mm_colorWithRGBHexString:rgbStrValue andAlpha:1.0];
}

+ (UIColor*)mm_colorWithRGBHexString:(NSString*)rgbStrValue andAlpha:(CGFloat)alpha
{
    MMColorType rgbHexValue;

    NSScanner* scanner = [NSScanner scannerWithString:rgbStrValue];
    BOOL successful = [scanner scanHexInt:&rgbHexValue];

    if (!successful)
        return nil;

    return [self mm_colorWithRGBHexValue:rgbHexValue andAlpha:alpha];
}

+ (UIColor*)mm_colorWithRGBAHexString:(NSString*)rgbaStrValue
{
    MMColorType rgbHexValue;
    
    NSScanner *scanner = [NSScanner scannerWithString:rgbaStrValue];
    BOOL successful = [scanner scanHexInt:&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self mm_colorWithRGBAHexValue:rgbHexValue];
}

- (BOOL)mm_getRGBHexValue:(MMColorType*)rgbHex
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4)
    {
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        
        MMColorType r = (MMColorType)roundf(rFloat*MM_COLOR_SIZE);
        MMColorType g = (MMColorType)roundf(gFloat*MM_COLOR_SIZE);
        MMColorType b = (MMColorType)roundf(bFloat*MM_COLOR_SIZE);
        
        *rgbHex = (r << MM_RED_SHIFT) + (g << MM_GREEN_SHIFT) + (b << MM_BLUE_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2)
    {
        CGFloat gFloat = components[0]; // gray
        
        MMColorType g = (MMColorType)roundf(gFloat*MM_COLOR_SIZE);
        
        *rgbHex = (g << MM_RED_SHIFT) + (g << MM_GREEN_SHIFT) + (g << MM_BLUE_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (BOOL)mm_getRGBAHexValue:(MMColorType*)rgbaHex;
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4)
    {
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        CGFloat aFloat = components[3]; // alpha
        
        MMColorType r = (MMColorType)roundf(rFloat*MM_COLOR_SIZE);
        MMColorType g = (MMColorType)roundf(gFloat*MM_COLOR_SIZE);
        MMColorType b = (MMColorType)roundf(bFloat*MM_COLOR_SIZE);
        MMColorType a = (MMColorType)roundf(aFloat*MM_COLOR_SIZE);
        
        *rgbaHex = (r << MM_RED_SHIFT) + (g << MM_GREEN_SHIFT) + (b << MM_BLUE_SHIFT) + (a << MM_ALPHA_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2)
    {
        CGFloat gFloat = components[0]; // gray
        CGFloat aFloat = components[1]; // alpha
        
        MMColorType g = (MMColorType)roundf(gFloat*MM_COLOR_SIZE);
        MMColorType a = (MMColorType)roundf(aFloat *MM_COLOR_SIZE);
        
        *rgbaHex = (g << MM_RED_SHIFT) + (g << MM_GREEN_SHIFT) + (g << MM_BLUE_SHIFT) + (a << MM_ALPHA_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (MMColorType)mm_RGBHexValue
{
    return 0;
}

- (MMColorType)mm_RGBAHexValue
{
    return 0;
}

- (NSString*)mm_RGBHexString
{
    MMColorType value = 0;
    BOOL compatible = [self mm_getRGBHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", value];
}

- (NSString*)mm_RGBAHexString
{
    MMColorType value = 0;
    BOOL compatible = [self mm_getRGBAHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", value];
}


+ (UIColor*)mm_colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue
{
    return [self mm_colorWithRed255:red green255:green blue255:blue alpha255:MM_COLOR_SIZE];
}

+ (UIColor*)mm_colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/MM_COLOR_SIZE green:green/MM_COLOR_SIZE blue:blue/MM_COLOR_SIZE alpha:alpha/MM_COLOR_SIZE];
}

- (UIColor*)mm_grayColor
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * components = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat luminiscence = 0.0;
    CGFloat alpha = 1.0;
    
    if (isGreyscale)
    {
        luminiscence = components[0];
        alpha = components[1];
    }
    else
    {
        luminiscence = components[0]*MM_LUM_RED + components[1]*MM_LUM_GREEN + components[2]*MM_LUM_BLUE;
        alpha = components[3];
    }
    
    return [UIColor colorWithWhite:luminiscence alpha:alpha];
}

- (UIColor*)mm_colorWithSaturation:(CGFloat)newSaturation
{
    CGFloat hue,saturation,brightness,alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
}

- (UIColor*)mm_colorWithBrightness:(CGFloat)newBrightness
{
    CGFloat hue,saturation,brightness,alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:alpha];
}


- (UIColor*)mm_lighterColorWithValue:(CGFloat)value
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    CGFloat (^actionBlock)(CGFloat component) = ^CGFloat(CGFloat component) {
        
        CGFloat offset = 1.0 - component;
        CGFloat newComponent = component + offset*value;
        
        // CGFloat newComponent = component + value > 1.0 ? 1.0 : component + value;
        
        return newComponent;
    };
    
    if (isGreyscale)
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[0]);
        newComponents[2] = actionBlock(oldComponents[0]);
        newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[1]);
        newComponents[2] = actionBlock(oldComponents[2]);
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (UIColor*)mm_darkerColorWithValue:(CGFloat)value
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    CGFloat (^actionBlock)(CGFloat component) = ^CGFloat(CGFloat component) {
        
        CGFloat newComponent = component * (1.0 - value);
        
        // CGFloat newComponent = component - value < 0.0 ? 0.0 : component - value;
        
        return newComponent;
    };
    
    if (isGreyscale)
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[0]);
        newComponents[2] = actionBlock(oldComponents[0]);
		newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[1]);
        newComponents[2] = actionBlock(oldComponents[2]);
		newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (BOOL)mm_isLightColor
{
    size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * components = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat sum;
    
    if (isGreyscale)
        sum = components[0];
    else
        sum = components[0]*MM_LUM_RED + components[1]*MM_LUM_GREEN + components[2]*MM_LUM_BLUE;
    
    return (sum > 0.8f);
}

- (BOOL)mm_isDarkColor
{
    return ![self mm_isLightColor];
}

+ (UIColor *)mm_randomColor
{
    return [UIColor colorWithRed:(arc4random()%256)/256.f
                           green:(arc4random()%256)/256.f
                            blue:(arc4random()%256)/256.f
                           alpha:1.0f];
}

@end
