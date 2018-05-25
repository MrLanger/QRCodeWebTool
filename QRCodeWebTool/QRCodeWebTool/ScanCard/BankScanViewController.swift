//
//  BankScanViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class BankScanViewController: ScanBaseViewController {

    lazy var overlayView: OverlayView = {
        let rect = OverlayView.getOverlayFrame(UIScreen.main.bounds)
        let overlayView = OverlayView(frame: rect)
        return overlayView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "银行卡扫描"
        
        view.insertSubview(overlayView, at: 0)
        cameraManager.sessionPreset = AVCaptureSessionPreset1280x720
        
        if cameraManager.configBankScanManager() == true {
            let bankView = UIView(frame: view.bounds)
            view.insertSubview(bankView, at: 0)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: cameraManager.captureSession)
            previewLayer?.frame = UIScreen.main.bounds
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            bankView.layer.addSublayer(previewLayer!)
            
        }else{
            print("打开相机失败")
            navigationController?.popViewController(animated: true)
        }
        
        cameraManager.bankScanSuccess = { sucess in
            self.showResult(resault: sucess)
            
            return
        };
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if cameraManager.configBankScanManager() == true {
            cameraManager.startSession()
        }
    }
    
    func showResult(resault: Any?) {
        if (resault != nil) {
            let model = resault as! ScanResultModel
            model.cardtype = BankCardType
            print(model.bankName,model.bankNumber)
            
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
