//
//  HttpTools.swift
//  08-Swift中闭包的使用
//
//  Created by 1 on 16/6/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

/*
 如果一个类继承了NSObject,那么在调用方法时,还是OC的发送消息
*/

class HttpTools {
    
    var finishedCallback : ((result : String) -> ())?
    
    // 闭包类型: (参数列表) -> (返回值的类型)  () -> ()
    // loadData:
    func loadData(finishedCallback: (result : String) -> ()) {
        
        self.finishedCallback = finishedCallback
        
        // 1.发送异步请求
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            print("发送异步请求:\(NSThread.currentThread())")
            
            // 2.回调主线程,将数据回调出去
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                print("回调主线程,回调数据:\(NSThread.currentThread())")
                
                finishedCallback(result: "json数据")
            })
        }
    }
    
    // 函数重载
    func loadData(age : Int) {
        
    }
}
