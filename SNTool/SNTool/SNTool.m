//
//  SNTool.m
//  SNTool
//
//  Created by sunDong on 2017/2/21.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTool.h"

#import "sys/utsname.h"

@implementation SNTool

+ (UIViewController *)getNextViewController
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(UIWindow * tmpWin in windows) {
            
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView * frontView = [[UIView alloc]init];
    
    if (window.subviews.count < 1) {
        frontView = window.rootViewController.view;
    } else {
        frontView = [[window subviews] objectAtIndex:0];
    }
    
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    
    if (result.presentedViewController) {
        result = result.presentedViewController;
        
        for (int i = 0; i < 100; ++i) {
            if (result.presentedViewController) {
                result = result.presentedViewController;
            } else {
                break;
            }
        }
    }
    NSLog(@"getNextViewController -- %@",NSStringFromClass([result class]));
    return result;
}
+ (id)firstResponderFromViewControllor:(UIViewController *)VC
{
    if (VC.isFirstResponder) {
        return self;
    }
    for (UIView *subView in VC.view.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
    }
    return nil;
}
+ (UIView *)firstResponderFromKeyWindow
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    SEL sel = NSSelectorFromString(@"firstResponder");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    UIView   * firstResponder = [keyWindow performSelector:sel];
#pragma clang diagnostic pop
    
    return firstResponder;
}

+ (UIImageView *__nullable)findHairlineImageViewFrom:(UIView *__nonnull)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewFrom:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (NSString *)getCurrentTimeFormat:(NSString *)format fromDate:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    if (format) {
        [formatter setDateFormat:format];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    if (!date) date = [NSDate date];
    return [formatter stringFromDate:date];
}
+ (NSString *)getTimeFromCurrentSecs:(NSTimeInterval)secs format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    if (format) {
        [formatter setDateFormat:format];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSDate *nextDate = [NSDate dateWithTimeInterval:secs sinceDate:[NSDate date]];
    
    return [formatter stringFromDate:nextDate];
}

+ (void)handleTimeDate:(NSDate *)date complete:(void(^)(NSUInteger year, NSUInteger month, NSUInteger day, NSUInteger weekDay, NSUInteger hour, NSUInteger minute, NSUInteger second))completeBlock
{
    NSCalendar  * calendar = [NSCalendar  currentCalendar];
    NSUInteger  unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents * conponent = [calendar components:unitFlags fromDate:date];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    completeBlock(conponent.year,
                  conponent.month,
                  conponent.day,
                  [weekdays[conponent.weekday] integerValue],
                  conponent.hour,
                  conponent.minute,
                  conponent.second);
    
    //    iOS 8_0 after:
    //    NSInteger hour = 0;
    //    NSInteger minute = 0;
    //    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    //    [currentCalendar getHour:&hour minute:&minute second:NULL nanosecond:NULL fromDate:date];
    //    NSLog(@"the hour is %ld and minute is %ld", (long)hour, (long)minute);
    
}

+ (NSString *)firstCharactor:(NSString *)aString
{
    NSMutableString * valueString = [NSMutableString string];
    for (int i = 0; i <aString.length; i++) {
        
        NSMutableString *str = [NSMutableString stringWithString:[aString substringWithRange:NSMakeRange(i, 1)]];
        
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);

        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);

        NSString *pinYin = [str capitalizedString];

        [valueString appendString:[pinYin substringToIndex:1]];
    }
    return valueString;
}

+ (BOOL)isChinese:(NSString *)aString
{
    NSString * string = [aString substringToIndex:1];
    int strlength = 0;
    char * p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return ((strlength/2)==1) ? YES : NO;
}

+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isHaveString:(NSString *)string InString:(NSString *)inString
{
    NSRange _range = [inString rangeOfString:string];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

+ (CGFloat)widthFromString:(NSString *)aString withRangeWidth:(CGFloat)aWidth font:(UIFont *)font
{
    CGRect rectToFit = [aString boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    
    return rectToFit.size.width;
}

+ (CGFloat)heightFromString:(NSString *)aString withRangeWidth:(CGFloat)aWidth font:(UIFont *)font
{
    CGRect rectToFit = [aString boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    
    return rectToFit.size.height;
}

+ (NSMutableAttributedString *__nonnull)attributedStringWithFixedText:(NSString *__nonnull)fixedText
                                                   highlightTextArray:(NSArray *__nonnull)highlightTextArray
                                                        locationArray:(NSArray *__nonnull)locationArray
                                                        lightTextFont:(UIFont *__nonnull)font
                                                           highColoer:(UIColor *__nonnull)highColoer
                                                         warningColor:(UIColor *__nullable)warningColor
                                                               atInde:(NSInteger)index
{
    NSMutableAttributedString *warningAttributedString = [[NSMutableAttributedString alloc]initWithString:fixedText];
    if (!(highlightTextArray.count == locationArray.count)) return warningAttributedString;
    
    NSMutableString *muString = [[NSMutableString alloc]initWithString:fixedText];
    for (int i = 0; i < highlightTextArray.count; i++) {
        NSInteger location = [locationArray[i] integerValue];
        for (int j = 0; j < i; j ++) {
            NSString * oldString = highlightTextArray[j];
            location += oldString.length;
        }
        [muString insertString:highlightTextArray[i] atIndex:location];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:muString];
    for (int i = 0; i < highlightTextArray.count; i ++) {
        NSString * string = highlightTextArray[i];
        NSInteger len = string.length;
        NSInteger location = [locationArray[i] integerValue];
        for (int j = 0; j < i; j ++) {
            NSString * oldString = highlightTextArray[j];
            location += oldString.length;
        }
        
        UIColor * color = highColoer;
        if (warningColor && i == index) color = warningColor;
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, len)];
        [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(location, len)];
    }
    
    return (NSMutableAttributedString *)attributedString;
}

+ (NSMutableAttributedString *__nonnull)attributedChangeFont:(UIFont *__nonnull)font
                                                       Color:(UIColor *__nonnull)color
                                                 TotalString:(NSString *__nonnull)totalString
                                              SubStringArray:(NSArray *__nonnull)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (NSString *rangeStr in subArray) {
        
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    
    return attributedStr;
}

+ (UIImage *)image:(UIImage *)image ToSize:(CGSize)toSize
{
    UIImage *sourceImage = image;
    
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(toSize);
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = toSize.width;
    thumbnailRect.size.height = toSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (void)addMaskToView:(UIView *)view withRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:cornerRadius] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    [view.layer setMask:shapeLayer];
}


+ (void)groundGlassView:(UIView *)view style:(NSInteger)style
{
    if (!(iOS8_0)) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:visualEffectView];
        
        NSDictionary * views = NSDictionaryOfVariableBindings(visualEffectView);
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[visualEffectView]|"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:views]];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[visualEffectView]|"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:views]];
    } else {
        UIToolbar * toolbar = [[UIToolbar alloc] init];
        toolbar.translatesAutoresizingMaskIntoConstraints = NO;
        toolbar.barStyle = style;
        [view addSubview:toolbar];
        
        NSDictionary * views = NSDictionaryOfVariableBindings(toolbar);
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolbar]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[toolbar]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
}

+ (CGFloat)interpolateFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent {
    return from + (to - from) * percent;
}

+ (NSString *__nullable)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNumber
{
    /*
     
     // 电信号段：2G/3G号段（CDMA2000网络）133、153、180、181、189
     4G号段 177、173
     // 联通号段：2G号段（GSM网络）130、131、132、155、156
     3G上网卡145
     3G号段（WCDMA网络）185、186
     4G号段 176、185
     // 移动号段：2G号段（GSM网络）有134x（0-8）、135、136、137、138、139、150、151、152、158、159、182、183、184
     3G号段（TD-SCDMA网络）有157、187、188
     3G上网卡 147
     4G号段 178、184
     // 虚拟运营商 170、171（1700电信、1705移动、1709联通）
     
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-136-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNumber];
}

+ (NSArray *)sortChineseWithArray:(NSArray *)aArray isAscending:(BOOL)isAscending {
    NSMutableArray * tempArray = [NSMutableArray array];
    NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < aArray.count; ++i) {
        NSString * keyString = [self firstCharactor:aArray[i]];
        [tempArray addObject:keyString];
        [tempDic setObject:aArray[i] forKey:keyString];
    }
    NSArray * sortedArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 localizedCompare:obj2] < 1) {
            if (isAscending) {
                return (NSComparisonResult)NSOrderedAscending;
            } else {
                return (NSComparisonResult)NSOrderedDescending;
            }
        } else {
            if (isAscending) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedAscending;
            }
        } return (NSComparisonResult)NSOrderedSame;
    }];
    NSMutableArray * vauleArray = [NSMutableArray array];
    for (int i = 0; i < sortedArray.count; ++i) {
        [vauleArray addObject:[tempDic objectForKey:sortedArray[i]]];
    } return vauleArray;
}
- (NSString *)firstCharactor:(NSString *)aString {
    NSMutableString * valueString = [NSMutableString string];
    for (int i = 0; i <aString.length; i++) {
        NSMutableString *str = [NSMutableString stringWithString:[aString substringWithRange:NSMakeRange(i, 1)]];
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        [valueString appendString:[str substringToIndex:1]];
    }
    return valueString;
}

+ (NSArray *)sortLetterWithArray:(NSArray *)aArray isAscending:(BOOL)isAscending {
    NSArray * sortedArray = [aArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (isAscending) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        } else {
            return [obj2 compare:obj1 options:NSNumericSearch];
        }
    }]; return sortedArray;
}

-(NSArray *)sortQuickWithArray:(NSArray *)aArray{
    NSMutableArray *sortedArray = [NSMutableArray array];
    for (int i = 0; i < aArray.count; ++i) {
        if ([aArray[i] isKindOfClass:[NSString class]]) {
            NSInteger inter = [aArray[i] integerValue];
            [sortedArray addObject:@(inter)];
        } else {
            [sortedArray addObject:aArray[i]];
        }
    } [self quickSortWithArray:sortedArray left:0 right:[aArray count]-1];
    return sortedArray;
}
- (void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right {
    if (right > left) {
        NSInteger i = left ;
        NSInteger j = right + 1;
        while (true) {
            while (i+1 < [aData count] && [aData objectAtIndex:++i] < [aData objectAtIndex:left]);
            while (j-1 > -1 && [aData objectAtIndex:--j] > [aData objectAtIndex:left]) ;
            if (i >= j) {
                break;
            }
            [self swapWithData:aData index1:i index2:j];
        }
        [self swapWithData:aData index1:left index2:j];
        [self quickSortWithArray:aData left:left right:j-1];
        [self quickSortWithArray:aData left:j+1 right:right];
    }
}
- (void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2 {
    NSNumber *tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}

@end
