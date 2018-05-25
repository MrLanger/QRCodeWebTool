//
//  ScanBaseManager.h
//  IDAndBankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "RectManager.h"
#import "BankCardSearch.h"
#import "UIImage+Extend.h"
#import "ScanResultModel.h"
#import "exbankcard.h"
#import "excards.h"


typedef enum : NSUInteger {
    BankScanType,
    IDScanType,
} kScanType;

@interface ScanBaseManager : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) BOOL                      verify;

@property (nonatomic, assign) kScanType scanType;

@property (nonatomic, copy) void(^receiveSubject)(id data);
@property (nonatomic, copy) void(^bankScanSuccess)(id data);
@property (nonatomic, copy) void(^idCardScanSuccess)(id data);
@property (nonatomic, copy) void(^scanError)(NSError* erro);

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, copy) NSString *sessionPreset; // 图片质量

@property (nonatomic, assign) BOOL isInProcessing;

@property (nonatomic, assign) BOOL isHasResult;

//出流
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
//输入流
@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput;

// 能否切换前置后置
- (BOOL)canSwitchCameras;

- (AVCaptureDevice *)activeCamera;

- (AVCaptureDevice *)inactiveCamera;
// 闪关灯
- (AVCaptureFlashMode)flashMode;
// 有无手电筒
- (BOOL)cameraHasTorch;

- (AVCaptureTorchMode)torchMode;
// 能否调整焦距
- (BOOL)cameraSupportsTapToFocus;


@end
