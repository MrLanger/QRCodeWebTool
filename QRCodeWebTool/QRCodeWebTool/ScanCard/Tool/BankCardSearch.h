//
//  BankCardSearch.h
//  BankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardSearch : NSObject

/**
 *  查询是哪个银行
 *
 *  @param numbers 获取的numbers
 *  @param nCount  数组个数
 *
 *  @return 所属银行
 */
+ (NSString *)getBankNameByBin:(char *)numbers count:(int)nCount;

@end
