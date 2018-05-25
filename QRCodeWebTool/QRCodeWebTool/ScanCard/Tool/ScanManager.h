//
//  ScanManager.h
//  IDAndBankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import "ScanManagerControl.h"

@interface ScanManager : ScanManagerControl

- (BOOL)configBankScanManager;

- (BOOL)configIDScanManager;

//- (void)doSomethingWhenWillAppear;    ScanManagerControl

//- (void)doSomethingWhenWillDisappear; ScanManagerControl

@end
