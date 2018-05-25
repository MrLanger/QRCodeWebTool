//
//  ScanResaultViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/5/18.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class ScanResaultViewController: UIViewController {

    @IBOutlet var resaultTextView: UITextView!
    var resaultTextStr:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(backAction))
        
        resaultTextView.text = resaultTextStr
    }
    
    func backAction() {
        navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
