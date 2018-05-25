//
//  BaseViewController.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/6/9.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit

extension UIViewController {
    func dismissModalVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置返回按钮
        let backItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backItem
        
        self.configSubViews()
    }
    
    func tabBarItemClicked() {
        
    }
    
    func configSubViews() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.navigationController?.viewControllers.count)!>1 {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }else{
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/// contrller跳转操作
extension BaseViewController {
    
    class func presentVC(viewController: UIViewController?) {
        if viewController == nil {
            return
        }
        let nav = UINavigationController.init(rootViewController: viewController!)
        if (viewController!.navigationItem.leftBarButtonItem == nil) {
            viewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: viewController, action: #selector(dismissModalVC))
        }
        self.presentingVC().present(nav, animated: true, completion: nil)
    }
    
    class func goToVC(viewController: UIViewController?) {
        if viewController == nil {
            return
        }
        
        let nav = self.presentingVC().navigationController
        if (nav != nil) {
            nav?.pushViewController(viewController!, animated: true)
        }
    }
    
    class func presentingVC() -> UIViewController {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for tmpwin: UIWindow in windows {
                if tmpwin.windowLevel == UIWindowLevelNormal {
                    window = tmpwin
                    break
                }
            }
        }
        
        var resault = window?.rootViewController
        while ((resault?.presentedViewController) != nil) {
            resault = resault?.presentedViewController
        }
        
        if (resault? .isKind(of: UITabBarController.self))!{
            let tempResault = resault as! UITabBarController
            resault = tempResault.selectedViewController
        }
        
        if (resault? .isKind(of: UINavigationController.self))!{
            let tempResault = resault as! UINavigationController
            resault = tempResault.topViewController
        }
        
        return resault!
    }
}
