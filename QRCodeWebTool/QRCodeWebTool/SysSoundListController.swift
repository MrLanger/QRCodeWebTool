//
//  SysSoundListController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/5/31.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit
import AudioToolbox

class SysSoundListController: UITableViewController {

    var systemSounds = [String]()
    let path = "/System/Library/Audio/UISounds"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

         systemSounds = accessSystemSoundsList()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return systemSounds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SysSoundCellID", for: indexPath)

        // Configure the cell...
        cell.detailTextLabel?.text = "\(indexPath.row)"
        cell.textLabel?.text = systemSounds[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        var soundId:SystemSoundID = 0
        let name = systemSounds[indexPath.row]
        let soundUrl = NSURL.fileURL(withPath: path + "/" + name)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
        AudioServicesPlaySystemSound(soundId)
    }
}

extension SysSoundListController{
    
    /**
     *  系统声音的列表
     *
     *  @return SoundInfomation对象数组
     */
    func accessSystemSoundsList() -> [String]{
        var soundsList = [String]()
        
        // 读取文件系统
        let fileManager  = FileManager()
        let files = fileManager.enumerator(atPath: path)
        while let file = files?.nextObject() as! String? {
            if file.hasSuffix("caf") {
                soundsList.append(file)
            }
        }
        return soundsList
    }
}


