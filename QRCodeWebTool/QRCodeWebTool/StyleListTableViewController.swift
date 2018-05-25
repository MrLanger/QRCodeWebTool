//
//  StyleListTableViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/5/17.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class StyleListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "styleListIdentifier", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "扫一扫"
        case 1:
            cell.textLabel?.text = "生成码"
        case 2:
            cell.textLabel?.text = "声音列表"
        case 3:
            cell.textLabel?.text = "扫描银行卡"
        case 4:
            cell.textLabel?.text = "扫描身份证"
//        case 5:
//            let user = UserDefaults.standard
//            let str = user.string(forKey: "UMPuserInfoNotification")
//            print(str ?? "")
//            cell.textLabel?.text = str
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "scanPushIdentifier", sender: indexPath)
        case 1:
            performSegue(withIdentifier: "creatCodeidentifier", sender: indexPath)
        case 2:
            performSegue(withIdentifier: "SystemSoundList", sender: indexPath)
        case 3:
            let bankctr = BankScanViewController()
            bankctr.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(bankctr, animated: true)
        case 4:
            let idcardkctr = IDCardScanViewController()
            idcardkctr.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(idcardkctr, animated: true)
            
        default :
            return
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexpath = sender as? IndexPath {
            switch indexpath.row {
            case 0:
                let scanCtr = segue.destination as! ScanViewController
                let style = ZhiFuBaoStyle()
                scanCtr.scanStyle = style
                
            default:
                return
            }
        }
    }
    
    
    //MARK: ---模仿支付宝------
    fileprivate func ZhiFuBaoStyle() -> LBXScanViewStyle{
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        
        style.centerUpOffset = 0;
        style.xScanRetangleOffset = 30;
        
        if UIScreen.main.bounds.size.height <= 480
        {
            //3.5inch 显示的扫码缩小
            style.centerUpOffset = 0;
            style.xScanRetangleOffset = 20;
        }
        
        style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2.0;
        style.photoframeAngleW = 16;
        style.photoframeAngleH = 16;
        
        style.isNeedShowRetangle = false;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_full_net")
        
        return style
    }

}
