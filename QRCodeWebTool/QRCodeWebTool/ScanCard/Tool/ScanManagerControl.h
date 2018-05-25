//
//  ScanManagerControl.h
//  IDAndBankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import "ScanManagerInitialize.h"

@interface ScanManagerControl : ScanManagerInitialize

- (void)startSession;

- (void)stopSession;

- (void)resetConfig;

- (void)resetParams;

- (void)doSomethingWhenWillAppear;

- (void)doSomethingWhenWillDisappear;

- (void)parseIDCardImageBuffer:(CVImageBufferRef)imageBuffer;

- (void)parseBankImageBuffer:(CVImageBufferRef)imageBuffer;

//选择前置和后置
- (BOOL)switchCameras;
// 闪关灯
- (void)setFlashMode:(AVCaptureFlashMode)flashMode;
// 手电筒
- (void)setTorchMode:(AVCaptureTorchMode)torchMode;
// 焦距
- (void)focusAtPoint:(CGPoint)point;
// 曝光量
- (void)exposeAtPoint:(CGPoint)point;
//重置曝光
- (void)resetFocusAndExposureModes;

@end
