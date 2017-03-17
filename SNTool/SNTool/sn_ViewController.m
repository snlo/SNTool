//
//  sn_ViewController.m
//  SNTool
//
//  Created by sunDong on 2017/3/6.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "sn_ViewController.h"

@interface sn_ViewController ()

@end

@implementation sn_ViewController

- (void)dealloc {
    NSLog(@"dealloc - - - %s",__func__);
}
//- (instancetype)init { /* ... */ }

#pragma mark - View Lifecycle （View 的生命周期）

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self.view window]  == nil) {
        
        self.view = nil;
    }
}

#pragma mark - Custom Accessors （自定义访问器）

#pragma mark - IBActions

#pragma mark - Public （公有方法、接口）

#pragma mark - Private （私有方法）

#pragma mark - Protocl （协议）

#pragma mark - _Superclass (重载超类的方法)

#pragma mark - NSObject （setter、getter）

@end

//@interface HomeViewController ()
//{
//    NSNumber * _number;
//}
//@property (nonatomic, strong) UIImage * image;
//
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UISlider *silder;
//
//@end
//
//@implementation HomeViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.title = @"首页";
//    
//    self.image = [UIImage imageNamed:@"屏幕快照 2017-03-14 下午5.12.48"];
//    
//    //    CIImage * inputImage = [[CIImage alloc] initWithImage:self.image];
//    //    CIContext * context = [CIContext contextWithOptions:nil];
//    //    SNSketchFilter * filter = [SNSketchFilter new];
//    //    filter.inputImage = inputImage;
//    //    CGImageRef cgImage = [context createCGImage:filter.outputImage fromRect:[inputImage extent]];
//    //    self.imageView.image = [UIImage imageWithCGImage:
//    _number = @0;
//    
//    //    self.imageView.image = [self blurryImage:self.image withBlurLevel:_number];
//    self.view.layer.contents = (__bridge id _Nullable)([self blurryImage:self.image withBlurLevel:@10].CGImage);
//    self.imageView.image = [self blurryImage:self.image withBlurLevel:@(12)];
//    
//    
//    
//    //    return;
//    //
//    //
//    //    // 1、创建输入图像，CIImage类型，这里使用一个网上图片。
//    //    CIImage *inputImage = [CIImage imageWithCGImage:self.image.CGImage];
//    //
//    //    // 2、构建一个滤镜图表
//    //    CIColor *sepiaColor = [CIColor whiteColor];
//    //    // 2.1 先构建一个 CIColorMonochrome 滤镜，并配置输入图像与滤镜参数
//    //    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome"
//    //                                      withInputParameters:@{@"inputColor" : sepiaColor,
//    //                                                            @"inputIntensity":@1.0}];
//    //    [monochromeFilter setValue:inputImage forKey:@"inputImage"];// 通过KVC来设置输入图像
//    //    // 2.2 先构建一个 CIVignette 滤镜
//    //    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignette"
//    //                                    withInputParameters:@{@"inputRadius" : @0.0,
//    //                                                          @"inputIntensity" :@1.0}];
//    //    [vignetteFilter setValue:monochromeFilter.outputImage forKey:@"inputImage"];// 以monochromeFilter的输出来作为输入
//    //
//    //    // 3、得到一个滤镜处理后的图片，并转换至 UIImage
//    //    // 创建一个 CIContext
//    //    CIContext *ciContext = [CIContext contextWithOptions:nil];
//    //    // 将 CIImage 过渡到 CGImageRef 类型
//    //    CGImageRef cgImage = [ciContext createCGImage:vignetteFilter.outputImage fromRect:inputImage.extent];
//    //    // 最后转换为 UIImage 类型
//    //    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
//    //    self.imageView.image = uiImage;
//    
//    
//    //    self.imageView.image = self.image;
//    
//    
//    [self groundGlassViewAtView:self.imageView style:1];
//    
//}
//
///**
// UIBlurEffectStyleExtraLight,
// UIBlurEffectStyleLight,
// UIBlurEffectStyleDark,
// 
// 0 --> light;
// 1 -->
// 
// @param view
// UIBarStyleDefault          = 0,
// UIBarStyleBlack            = 1,
// @param style <#style description#>
// */
//- (void)groundGlassViewAtView:(UIView *)view style:(NSInteger)style
//{
//    if ((iOS8_0)) {
//        
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
//        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//        visualEffectView.frame = view.bounds;
//        [view addSubview:visualEffectView];
//        
//        
//    } else {
//        
//        UIToolbar * toolbar = [[UIToolbar alloc] init];
//        toolbar.frame = view.bounds;
//        toolbar.barStyle = style;
//        [view addSubview:toolbar];
//    }
//    
//}
//
//- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(NSNumber *)blur
//{
//    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
//    //    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
//    //                                  keysAndValues:kCIInputImageKey, inputImage, @"inputRadius", blur, nil ,nil];
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setDefaults];
//    [filter setValue:blur forKey:kCIInputRadiusKey];
//    [filter setValue:inputImage forKey:kCIInputImageKey];
//    CIImage *outputImage = filter.outputImage;
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
//    return [UIImage imageWithCGImage:outImage];
//}
//- (IBAction)handleSilder:(UISlider *)sender {
//    
//    SNLog(@"%@",@(sender.value * 100));
//    
//    self.imageView.image = [self blurryImage:self.image withBlurLevel:@(sender.value * 100)];
//}
//
//
//@end
