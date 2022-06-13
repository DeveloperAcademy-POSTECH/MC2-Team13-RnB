//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    @State private var currentStage: Int = 0
    @EnvironmentObject var permissionManager: PermissionManager
    @State private var stepInfo: Step?
    
    @Binding var goToTutorialPage: Bool
    
    let courseInfo: RecipeVO
    
    var body: some View {
        Text("Welcome")
        TabView(selection: $currentStage) {
            
        }
//        TabView(selection: $currentStage) {
//            Button {
//                // Go to Setting
//            } label: {
//                Text("Go To Red View")
//            }
//            .gesture(DragGesture())
//            .tag(0)
//
//
//
//            StageView1().tag(1)
//            StageView2().tag(2)
//            StageView3().tag(3)
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//        .onAppear(perform: {
//            NetworkManager.shared.getStepInfo(course: courseInfo, stepNumber: self.currentStage) { stepInfo in
//                if let stepInfo = stepInfo {
//                    self.stepInfo = stepInfo
//                }
//            }
//        })
//        .navigationBarHidden(true)
        
    }
}


struct StageView1: View {
    var body: some View {
        Color.red
    }
}

struct StageView2: View {
    var body: some View {
        Color.blue
    }
}

struct StageView3: View {
    var body: some View {
        Color.green
    }
}

struct StagePagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StagePagingView(goToTutorialPage: .constant(true), courseInfo: RecipeVO())
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
