//
//  CardReasultTableViewCell.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/6/12.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class CardReasultTableViewCell: UITableViewCell {

//    var model:ScanResultModel?
    
    @IBOutlet weak var cardTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    lazy var signImgView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        imgView.image = UIImage(named: "yinlian.png")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        cardTextField.rightView = signImgView
    }
    
    var model:ScanResultModel?{
        didSet{
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
