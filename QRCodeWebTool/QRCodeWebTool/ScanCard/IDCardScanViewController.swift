//
//  IDCardScanViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/6/12.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class IDCardScanViewController: ScanBaseViewController {

    lazy var overlayView: OverlayView = {
        let rect = OverlayView.getOverlayFrame(UIScreen.main.bounds)
        let overlayView = OverlayView(frame: rect)
        return overlayView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "身份证扫描"
        
        view.insertSubview(overlayView, at: 0)
        cameraManager.sessionPreset = AVCaptureSessionPreset1280x720
        
        if cameraManager.configIDScanManager() == true {
            let preView = UIView(frame: view.bounds)
            view.insertSubview(preView, at: 0)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: cameraManager.captureSession)
            previewLayer?.frame = UIScreen.main.bounds
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            preView.layer.addSublayer(previewLayer!)
            
        }else{
            print("打开相机失败")
            navigationController?.popViewController(animated: true)
        }
        
        cameraManager.idCardScanSuccess = { sucess in
            self.showResult(resault: sucess)
            
            return
        };
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if cameraManager.configIDScanManager() == true {
            cameraManager.startSession()
        }
    }
    
    func showResult(resault: Any?) {
        if (resault != nil) {
            let model = resault as! ScanResultModel
            model.cardtype = IDCardType
            let ctr = CardReasultTableViewController()
            ctr.model = model
            ctr.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ctr, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
