//
//  CardReasultTableViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/6/12.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

class CardReasultTableViewController: UITableViewController {

    var model: ScanResultModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "扫描结果"
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CardReasultTableViewCell", bundle: nil), forCellReuseIdentifier: "resaultID")
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row==0 ? 60 : 40
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (model?.type == 1) ? 5 : 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resaultID", for: indexPath) as! CardReasultTableViewCell
        
        if model?.cardtype == BankCardType {
            cell.cardTextField.rightViewMode = (indexPath.row == 0) ? .always : .never
            cell.nameLabel.text = (indexPath.row == 0) ? "银行" : "卡号"
            cell.cardTextField.text = (indexPath.row == 0) ? model?.bankName : model?.bankNumber
            
        }else{
            cell.cardTextField.rightViewMode = .never
            if model?.type != 1 {
                cell.nameLabel.text = (indexPath.row == 0) ? "签发机关" : "有效期"
                cell.cardTextField.text = (indexPath.row == 0) ? model?.issue : model?.valid
            }else{
                switch indexPath.row {
                case 0:
                    cell.nameLabel.text = "姓名"
                    cell.cardTextField.text = model?.name
                case 1:
                    cell.nameLabel.text = "性别"
                    cell.cardTextField.text = model?.gender
                case 2:
                    cell.nameLabel.text = "民族"
                    cell.cardTextField.text = model?.nation
                case 3:
                    cell.nameLabel.text = "身份证号"
                    cell.cardTextField.text = model?.code
                case 4:
                    cell.nameLabel.text = "地址"
                    cell.cardTextField.text = model?.address
                default:
                    cell.nameLabel.text = "身份证号"
                    cell.cardTextField.text = model?.code
                }
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIImageView(frame: CGRect(x: 15, y: 0, width: UIScreen.main.bounds.size.width-30, height: 200))
        headerView.backgroundColor = UIColor.white
        
        headerView.contentMode = .scaleAspectFit
        headerView.image = model?.cardtype == BankCardType ? model?.bankImage :model?.idImage
        
        return headerView
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }

}
