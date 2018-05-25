//
//  ScanBaseViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class ScanBaseViewController: BaseViewController {

    lazy var cameraManager: ScanManager = ScanManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraManager.doSomethingWhenWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.doSomethingWhenWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
