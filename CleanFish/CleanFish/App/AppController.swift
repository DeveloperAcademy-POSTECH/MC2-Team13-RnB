//
//  AppController.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/14.
//

import Foundation
import SwiftUI

class AppController: ObservableObject {
    @Published var showView: ShowView = ( true, false)
    @Published var isSelectRecipe: Bool = false
    
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
            withAnimation {
                self.showView.fishView = true
            }
        }
    }
    
    func showRecipeView() {
        showView.fishView = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showView.recipeView = true
        }
    }
    
    func goToHome() {
        self.isSelectRecipe = false
        print(#function)
//        self.showFishView()
//        DispatchQueue.main.async {
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
//                                      forKey: "orientation")
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//            self.isSelectRecipe = false
//            self.showFishView()
//        }
    }
    
    func initBuffer() {
        @AppStorage("STEP_BUFFER") var stepMemory = 0
        @AppStorage("COURSE_NAME_BUFFER") var courseMemory = ""
        
        stepMemory = 0
        courseMemory = ""
    }
}
