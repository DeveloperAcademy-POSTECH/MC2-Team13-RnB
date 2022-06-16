//
//  MainView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

typealias ShowView = (fishView: Bool, recipeView: Bool)

struct MainView: View {
    @EnvironmentObject var appController: AppController
    @State var selectedFish: Fish = .flatfish
    @State var backgroudPosition = 0.0
    @State var isShowContinueAlert = false
    
    @StateObject var ePopToRoot: PopToRoot = PopToRoot(popToRootBool: false)
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if !appController.isMemoryEmpty {
                        NavigationLink("", isActive: $appController.goToStagePagingView) {
                            StepSlideView()
                        }
                        .hidden()
                    }
                    
                    LottieView(fileName: "wave", animationSpeed: 1)
                        .animation(.linear(duration: 0.4), value: UUID())
                        .offset(x: 0, y: appController.showView.fishView ? 0 : UIScreen.main.bounds.height * 0.7)
                    ZStack {
                        if self.appController.showView.fishView {
                            SelectFishView(selectedFish: $selectedFish)
                        }
                    }
                    ZStack {
                        if self.appController.showView.recipeView {
                            SelectRecipeView(selectedFish: $selectedFish)
                        }
                    }
                }
                .alert("이어보기", isPresented: $isShowContinueAlert) {
                    VStack {
                        Button("취소", role: .cancel) {
                            appController.initBuffer()
                        }
                        Button("확인", role: .none) {
                            appController.mainWhiteForeground.toggle()
                            DispatchQueue.main.async {
                                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                                          forKey: "orientation")
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.appController.goToStagePagingView = true
                            }
                        }
                    }
                } message: {
                    Text("손질 중이던 생선이 있습니다.\n계속 보시겠습니까?")
                }
            }
            .onAppear {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                          forKey: "orientation")
                AppDelegate.orientationLock = .portrait
                
                if !appController.isMemoryEmpty {
                    NetworkManager.shared
                        .getTotalStep(courseName: appController.getMemory.courseID) { courseInfo in
                            if let courseInfo = courseInfo {
                                self.appController.courseInfo = courseInfo
                                self.isShowContinueAlert = true
                            }
                        }
                }
                
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            .padding(.top)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .environmentObject(ePopToRoot)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
