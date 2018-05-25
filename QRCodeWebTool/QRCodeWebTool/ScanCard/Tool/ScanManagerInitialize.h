//
//  ScanManagerInitialize.h
//  IDAndBankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import "ScanBaseManager.h"

@interface ScanManagerInitialize : ScanBaseManager

- (void)configIDScan;

- (BOOL)configOutPutAtQue:(dispatch_queue_t)queue;

- (BOOL)configInPutAtQue:(dispatch_queue_t)queue;

- (void)configConnection;


@end
