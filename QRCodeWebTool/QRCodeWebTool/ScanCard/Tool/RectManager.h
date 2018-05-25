//
//  RectManager.h
//  BankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RectManager : UIView


@property (nonatomic, assign)CGRect subRect;

+ (CGRect)getEffectImageRect:(CGSize)size;
+ (CGRect)getGuideFrame:(CGRect)rect;

+ (int)docode:(unsigned char *)pbBuf len:(int)tLen;
+ (CGRect)getCorpCardRect:(int)width  height:(int)height guideRect:(CGRect)guideRect charCount:(int) charCount;

+ (char *)getNumbers;

@end
