//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    @EnvironmentObject var appController: AppController
    
    @AppStorage("STEP_BUFFER") var stepMemory = 0
    
    @State private var currentStage: Int = 0
    @State private var isVoiceFunctionOn = false
    @State private var isShowPermissionAlert = false
    @State private var isShowGoToHomeAlert = false
    
    @StateObject var permissionManager: PermissionManager = PermissionManager()
    
    
    // MARK: - [애플리케이션 설정창 이동 실시 : 권한 거부 시]
    func goAppSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("staticwave")
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 1)
            }
            .ignoresSafeArea()
            
            TabView(selection: $currentStage) {
                ForEach(1...appController.courseInfo.totalStep, id: \.self) { stepNumber in
                    StageLayout75View(stepNumber: stepNumber, // appController: appController,
                                      currentStage: $currentStage)
                        .tag(stepNumber)
                }
            }
            .onChange(of: currentStage) { num in
                stepMemory = num
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                if !appController.getMemory.courseID.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        currentStage = appController.getMemory.courseStep
                    }
                }
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                          forKey: "orientation")
            }
        }
        .navigationBarHidden(true)
    }
}

struct StagePagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StagePagingView()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
