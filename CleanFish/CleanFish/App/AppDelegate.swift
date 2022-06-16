//
//  AppDelegate.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/15.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
