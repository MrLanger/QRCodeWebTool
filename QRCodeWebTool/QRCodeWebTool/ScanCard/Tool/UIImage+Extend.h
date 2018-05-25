//
//  UIImage+Extend.h
//  BankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

+ (UIImage *)getImageStream:(CVImageBufferRef)imageBuffer;
+ (UIImage *)getSubImage:(CGRect)rect inImage:(UIImage*)image;

@end
