//
//  MainViewController.swift
//  NJWB
//
//  Created by 李南江 on 15/11/30.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加所有子控制器
        addChildViewControllers()
    }
    
    /**
     添加所有子控制
     */
    func addChildViewControllers() {

        // 1.获取json文件路径
        let jsonPath = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)!
        
        // 2.加载json数据
        let jsonData = NSData(contentsOfFile: jsonPath)
        
        // 3.序列化json
        guard let dictArray = try? NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) else
        {
            addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
            addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            addChildViewController("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            return
        }
        
        // 4.遍历字典时候需要明确指明数组中的数据类型
        for dict in dictArray  as! [[String:String]]
        {
            // 由于addChildVC方法参数不能为nil, 但是字典中取出来的值可能是nil, 所以需要加上!
            addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
        }
        
    }
    
    /**
     初始化子控制器
     
     :param: childController 需要初始化的子控制器
     :param: title           初始化的标题
     :param: imageName       初始化的图片
     */
      func addChildViewController(childControllerName: String, title:String, imageName:String) {
     
        // 0.动态获取命名空间
        let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String

        // 1.拼接命名空间并生成Class
        // 在Swift中, 如果想通过一个字符串创建一个类, 那么该类名必须包含命名空间名称
        guard let cls:AnyClass = NSClassFromString(namespace + "." + childControllerName) else {
            return
        }
        
        // 2.告诉编译器真实类型是UIViewController
        // 在Swift中如果向通过一个AnyClass来创建一个对象, 必须先明确这个类的类型
        // 通过 AnyObject.Type 这种方式所得到是一个类的类型
        let vcCls = cls as! UITableViewController.Type
        
        // 3.实例化控制器
        let childController = vcCls.init()
        
        // 1.从内像外设置, nav和tabbar都有
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 注意: Xocde7之前只有文字有效果, 还需要设置图片渲染模式
        tabBar.tintColor = UIColor.orangeColor()
        
        // 2.创建导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        
        // 3.添加控制器到tabbarVC
        addChildViewController(nav)
        
    }

}
