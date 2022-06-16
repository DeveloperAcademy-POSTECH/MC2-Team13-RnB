//
//  AppController.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/14.
//

import Foundation
import SwiftUI

class AppController: ObservableObject {
    @Published var showView: ShowView = (true, false)
    @Published var isSelectRecipe: Bool = false
    @Published var goToStagePagingView = false
    @Published var mainWhiteForeground: Bool = false
    
    var getMemory: (courseID: String, courseStep: Int) {
        @AppStorage("STEP_BUFFER") var stepMemory = 0
        @AppStorage("COURSE_NAME_BUFFER") var courseMemory = ""
        
        return (courseMemory, stepMemory)
    }
    
    var isMemoryEmpty: Bool {
        @AppStorage("STEP_BUFFER") var stepMemory = 0
        @AppStorage("COURSE_NAME_BUFFER") var courseMemory = ""
        return courseMemory.isEmpty || stepMemory == 0
    }
    
    var courseInfo: RecipeVO = RecipeVO()
    
    func showFishView() {
        showView.recipeView = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.linear(duration: 0.4)) {
                self.showView.fishView = true
            }
        }
    }
    
    func showRecipeView() {
        withAnimation(.linear(duration: 0.5)) {
            showView.fishView = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showView.recipeView = true
        }
    }
    
    func goToHome() {
        // 네비게이션 Pop 변수
        goToStagePagingView = false
        
        // 메인화면 생선선택View로 전환
        self.showFishView()
        
        // 화면 세로로 돌리기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                      forKey: "orientation")
            AppDelegate.orientationLock = .portrait
        }
        
        // 메인화면 View를 가려놨던 흰색 View 치우기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.mainWhiteForeground = false
        }
    }
    
    func initBuffer() {
        @AppStorage("STEP_BUFFER") var stepMemory = 0
        @AppStorage("COURSE_NAME_BUFFER") var courseMemory = ""
        
        stepMemory = 0
        courseMemory = ""
    }
}
