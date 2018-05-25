//
//  CreatCodeViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/5/18.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class CreatCodeViewController: UIViewController {

    @IBOutlet var mainTestView: UITextView!
    @IBOutlet var qrCodeImgView: UIImageView!
    
    @IBOutlet var lineCodeImgVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let str = "输入文本生成需要码"
        creatcode(text: str)
    }

    @IBAction func creatAction(_ sender: Any) {
        
        guard let resaultStr: String = mainTestView.text else {
            
            return
        }
        creatcode(text: resaultStr)
        
    }
    
    func creatcode(text:String) {
         let qrImgQ = (qrCodeImgView.bounds.size.height<qrCodeImgView.bounds.size.width) ? qrCodeImgView.bounds.size.height : qrCodeImgView.bounds.size.width
        let qrImg = LBXScanWrapper.createCode(codeType: "CIQRCodeGenerator",codeString:text, size:CGSize(width: qrImgQ, height: qrImgQ) , qrColor: UIColor.black, bkColor: UIColor.white)
        let logoImg = UIImage(named: "logo.JPG")
        let resaultImg = LBXScanWrapper.addImageLogo(srcImg: qrImg!, logoImg: logoImg!, logoSize: CGSize(width: 30, height: 30))
        qrCodeImgView.image = resaultImg
        
        let lineImg = LBXScanWrapper.createCode128(codeString: "121312312", size:lineCodeImgVIew.bounds.size , qrColor: UIColor.black, bkColor: UIColor.white)
        lineCodeImgVIew.image = lineImg
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
