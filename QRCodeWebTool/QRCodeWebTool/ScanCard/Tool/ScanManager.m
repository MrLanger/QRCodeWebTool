//
//  ScanManager.m
//  IDAndBankCard
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

#import "ScanManager.h"

@interface ScanManager ()

@end

@implementation ScanManager

- (BOOL)configBankScanManager {
    self.scanType = BankScanType;
    return [self configSession];
}

- (BOOL)configIDScanManager {
    [self configIDScan];
    self.verify = YES;
    self.scanType = IDScanType;
    return [self configSession];
}

- (BOOL)configSession {
    [self resetConfig];
    dispatch_queue_t captureQueue = dispatch_queue_create("www.captureQue.com", NULL);
    self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    
    if (![self configInPutAtQue:captureQueue] || ![self configOutPutAtQue:captureQueue]) {
        return NO;
    }
    [self configConnection];
    
    AVCaptureDevice *device = [self activeCamera];

    if(YES == [device lockForConfiguration:NULL]) {
        
        if([device respondsToSelector:@selector(setSmoothAutoFocusEnabled:)] && [device isSmoothAutoFocusSupported]) {
            [device setSmoothAutoFocusEnabled:YES];
        }
        AVCaptureFocusMode currentMode = [device focusMode];
        if(currentMode == AVCaptureFocusModeLocked) {
            
            currentMode = AVCaptureFocusModeAutoFocus;
        }
        if([device isFocusModeSupported:currentMode]) {
            
            [device setFocusMode:currentMode];
        }
        [device unlockForConfiguration];
    }
    [self.captureSession commitConfiguration];
    
    __weak __typeof(&*self)weakSelf = self;
    self.receiveSubject = ^(id data) {
        CVImageBufferRef imageBuffer = (__bridge CVImageBufferRef)(data);
        [weakSelf doRec:imageBuffer];
    };
    
//    self.bankScanSuccess = ^(id data) {
//        
//    };
//    
//    self.idCardScanSuccess = ^(id data) {
//        
//    };
//    
//    self.scanError = ^(NSError *erro) {
//        
//    };

    return YES;
}

- (void)doRec:(CVImageBufferRef)imageBuffer {
    @synchronized(self) {
        self.isInProcessing = YES;
        if (self.isHasResult) {
            return;
        }
        CVBufferRetain(imageBuffer);
        if(CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess) {
            switch (self.scanType) {
                case BankScanType: {
                    [self parseBankImageBuffer:imageBuffer];
                }
                    break;
                case IDScanType: {
                    [self parseIDCardImageBuffer:imageBuffer];
                }
                    break;
                default:
                    break;
            }
        }
        CVBufferRelease(imageBuffer);
    }
}

@end
