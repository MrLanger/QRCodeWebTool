//
//  StyleListTableViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/5/17.
//  Copyright © 2017年 besonit. All rights reserved.

import UIKit
import SafariServices

class ScanViewController: LBXScanViewController {
    
    
    /**
    @brief  扫码区域上方提示文字
    */
    var topTitle:UILabel?

    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash:Bool = false
    
// MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    
    //底部显示的功能项
    var bottomItemsView:UIView?
    
    //相册
    var btnPhoto:UIButton = UIButton()
    
    //闪光灯
    var btnFlash:UIButton = UIButton()
    
    //我的二维码
    var btnMyQR:UIButton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: false)
        
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10
 
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        drawBottomItems()
    }
    
    
// MARK: - 扫描结果
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        for result:LBXScanResult in arrayResult{
            if let str = result.strScanned {
                print(str)
            }
        }
        
        let result:LBXScanResult = arrayResult[0]
        guard let urlstr = result.strScanned else {
            showMsg(title: "错误", message: "二维码错误")
            return
        }
        
        guard let url = NSURL(string: urlstr),
            UIApplication.shared.canOpenURL(url as URL)==true
            else {
            unowned let weakSelf = self
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                weakSelf.performSegue(withIdentifier: "resaultIdentifier", sender: urlstr)
            }
            
            return
        }
        
        if #available(iOS 9.0, *) {
            let safariVC = SFSafariViewController(url: url as URL)
            safariVC.delegate = self;
            self.showDetailViewController(safariVC, sender: nil)
        } else {
            // Fallback on earlier versions
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resaultCtr = segue.destination as! ScanResaultViewController
        let resaultStr = sender as? String
        resaultCtr.resaultTextStr = resaultStr!
    }
    
    func drawBottomItems(){
        if (bottomItemsView != nil) {
            
            return;
        }
        
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        bottomItemsView = UIView(frame:CGRect(x: 0.0, y: yMax-100,width: self.view.frame.size.width, height: 100 ) )
        
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view .addSubview(bottomItemsView!)
        
        
        let size = CGSize(width: 65, height: 87);
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: bottomItemsView!.frame.width/2, y: bottomItemsView!.frame.height/2)
        btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        btnFlash.addTarget(self, action: #selector(ScanViewController.openOrCloseFlash), for: UIControlEvents.touchUpInside)
        
        
        self.btnPhoto = UIButton()
        btnPhoto.bounds = btnFlash.bounds
        btnPhoto.center = CGPoint(x: bottomItemsView!.frame.width/4, y: bottomItemsView!.frame.height/2)
        btnPhoto.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_photo_nor"), for: UIControlState.normal)
        btnPhoto.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_photo_down"), for: UIControlState.highlighted)
        btnPhoto.addTarget(self, action: Selector(("openPhotoAlbum")), for: UIControlEvents.touchUpInside)
        
        
        self.btnMyQR = UIButton()
        btnMyQR.bounds = btnFlash.bounds;
        btnMyQR.center = CGPoint(x: bottomItemsView!.frame.width * 3/4, y: bottomItemsView!.frame.height/2);
        btnMyQR.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"), for: UIControlState.normal)
        btnMyQR.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_myqrcode_down"), for: UIControlState.highlighted)
        btnMyQR.addTarget(self, action: #selector(ScanViewController.myCode), for: UIControlEvents.touchUpInside)
        
        bottomItemsView?.addSubview(btnFlash)
        bottomItemsView?.addSubview(btnPhoto)
        bottomItemsView?.addSubview(btnMyQR)
        
        self.view .addSubview(bottomItemsView!)
    }
    
    //开关闪光灯
    func openOrCloseFlash(){
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash{
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_down"), for:UIControlState.normal)
        }
        else{
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        }
    }
    
    func myCode(){
//        let vc = MyCodeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ScanViewController: SFSafariViewControllerDelegate{
    
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: false)
    }
}
