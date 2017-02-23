//
//  SNTool.h
//  SNTool
//
//  Created by sunDong on 2017/2/21.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define iOS8_0 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0

#define iOS7_0 7.0 <= [[[UIDevice currentDevice] systemVersion] doubleValue] <= 8.0

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SNTool : NSObject

/** @return 任意对象的上一个响应者ViewContrllor实咧 */
+ (UIViewController *__nonnull)getNextViewController;

/** 获取指定视图的第一响应者
 *
 *  @param VC 目标视图控制器
 *  @return 目标视图中的第一响应者 */
+ (id __nullable)firstResponderFromViewControllor:(UIViewController *__nonnull)VC;

/**
 *  获取当前窗口的第一响应者
 *
 *  通过接入apple的非公开API，为了避免可能被拒使用SEL的方式让apple忽视。当中还使用到忽视某个警告的方法（查阅自：http://www.jianshu.com/p/eb03e20f7b1c，右键Reveal in Log）*/
+ (UIView * __nullable)firstResponderFromKeyWindow;

/**
 *  找出导航栏下方的极细分割线
 *
 *  @param view navigationBar */
+ (UIImageView *__nullable)findHairlineImageViewFrom:(UIView *__nonnull)view;

/**
 *  随机数
 *
 *  @param from 包含的最小整数
 *  @param to   包含的最大整数
 *
 *  @return 随机整数
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 *  获取但前时间，默认格式：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @param format 当为nil，时间的格式为默认
 *
 *  @return 当前时间
 */
+ (NSString *__nonnull)getCurrentTimeFormat:(NSString *__nullable)format fromDate:(NSDate *__nullable)date;
/**
 *  获取距离当前时间，默认格式：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @param secs   时间间隔，秒，after就传正数，before就传负数 eg:在此之前3天 -24 * 60 * 60 * 3
 *  @param format 当为nil，时间的格式为默认
 *
 *  @return 距离当前时间secs秒
 */
+ (NSString *__nonnull)getTimeFromCurrentSecs:(NSTimeInterval)secs format:(NSString *__nullable)format;
+ (void)handleTimeDate:(NSDate *__nonnull)date complete:(void(^ _Nonnull)(NSUInteger year, NSUInteger month, NSUInteger day, NSUInteger weekDay, NSUInteger hour, NSUInteger minute, NSUInteger second))completeBlock;
/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString *__nullable)deviceVersion;

/**
 *  获取中文首字母
 *  判断string是否为中文
 *  判断string是否为空或全是空格
 *  判断字符串中是否含有某个字符串
 */
+ (NSString *__nonnull)firstCharactor:(NSString *__nonnull)aString;
+ (BOOL)isChinese:(NSString *__nonnull)aString;
+ (BOOL)isBlankString:(NSString *__nonnull)string;
+ (BOOL)isHaveString:(NSString *__nonnull)string InString:(NSString *__nonnull)inString;

/**
 *  获取string的长度
 *
 *  @param aWidth string
 *  @param font  string的字体大小
 *
 *  @return string的长度 CGFloat
 */
+ (CGFloat)widthFromString:(NSString * __nonnull)aString withRangeWidth:(CGFloat)aWidth font:(UIFont * __nonnull)font;
+ (CGFloat)heightFromString:(NSString *__nonnull)aString withRangeWidth:(CGFloat)aWidth font:(UIFont *__nonnull)font;

/**
 *  NSString的简单富文本 动态属性编辑
 *
 *  @param fixedText          string
 *  @param highlightTextArray 要插入的string
 *  @param locationArray      插入位置 用string表示
 *  @param font               要插入的字体
 *  @param highColoer         highColoer description
 *  @param warningColor       warningColor description
 *  @param index              warningColor所在位置（第几个出入字段）
 *
 *  @return AttributedString类似于突出显示的警示文本
 */
+ (NSMutableAttributedString *__nonnull)attributedStringWithFixedText:(NSString *__nonnull)fixedText
                                                   highlightTextArray:(NSArray <NSString *>*__nonnull)highlightTextArray
                                                        locationArray:(NSArray <NSString *>*__nonnull)locationArray
                                                        lightTextFont:(UIFont *__nonnull)font
                                                           highColoer:(UIColor *__nonnull)highColoer
                                                         warningColor:(UIColor *__nullable)warningColor
                                                               atInde:(NSInteger)index;
/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *__nonnull)attributedChangeFont:(UIFont *__nonnull)font
                                                       Color:(UIColor *__nonnull)color
                                                 TotalString:(NSString *__nonnull)totalString
                                              SubStringArray:(NSArray *__nonnull)subArray;

/**
 *  剪切图片
 *
 *  @param image  剪切对象
 *  @param toSize 目标尺寸
 *
 *  @return 目标图片
 */
+ (UIImage *__nonnull)image:(UIImage *__nonnull)image ToSize:(CGSize)toSize;

/**
 *  透明遮照,透视到父控制器上去，通俗的说是在view上抠了个孔
 *
 *  @param view         添加对象
 *  @param roundedRect  遮照矩形
 *  @param cornerRadius 矩形圆角
 */
+ (void)addMaskToView:(UIView *__nonnull)view withRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)cornerRadius;

/**
 *  实现模糊效果（兼容到iOS_7，在iOS8以前用的是UIToolbar，在iOS8以后用的是UIVisualEffectView。当然这两者的效果也是有所不同）
 *  不建议让其参加CaorAnimation动画
 *  @param view  被模糊对象
 *  @param color 模糊颜色,设置它的alpha值从0~1模糊度由低变高
 *  @param alpha 模糊透明度，值为0时，不存在模糊度。
 */
+ (void)addVisualEffectViewAtView:(UIView * __nonnull)view withColor:(UIColor * __nullable)color alpha:(CGFloat)alpha;

/**
 *  线性插值
 *
 *  @param from    起始值
 *  @param to      结束值
 *  @param percent 另一个变量当前变化值占总可变值的百分比
 *
 *  @return 插值结果
 */
+ (CGFloat)interpolateFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;


/**
 *  手机号码验证
 *  @param mobileNumber 需要验证的手机号
 *
 *  @return 查证百度百科的手机号段
 */
+ (BOOL)isMobileNumber:(NSString *__nonnull)mobileNumber;

//2016.10.14
/**
 *  中文排序（可混合英文和数字string）（优先数字、英文）
 *  @param aArray      排序前的数组
 *  @param isAscending YES为升序，NO为降序
 *
 *  @return 排序后的数组
 */
+ (NSArray *__nonnull)sortChineseWithArray:(NSArray *__nonnull)aArray isAscending:(BOOL)isAscending;

/**
 *  纯英文字母排序
 *
 *  @param aArray      排序前的数组
 *  @param isAscending YES为升序，NO为降序
 *
 *  @return 排序后的数组
 */
+ (NSArray *__nonnull)sortLetterWithArray:(NSArray *__nonnull)aArray isAscending:(BOOL)isAscending;

@end
