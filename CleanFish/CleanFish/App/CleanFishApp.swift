//
//  CleanFishApp.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/06.
//

import SwiftUI

@main
struct CleanFishApp: App {
    @ObservedObject private var appController: AppController = AppController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appController)
        }
    }
}
