//
//  StepSlideView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StepSlideView: View {
    // MARK: - EnvironmentObject
    @EnvironmentObject var appController: AppController
    
    // MARK: - AppStorage
    @AppStorage("STEP_BUFFER") var stepMemory = 1
    
    // MARK: - State
    @State private var currentStage: Int = 1
    @State private var isVoiceFunctionOn = false
    @State private var isShowPermissionAlert = false
    @State private var isShowGoToHomeAlert = false
    @State private var voiceCommand: Int = 0 // -1: 이전, 0: 노이즈, 1: 다음
    
    // MARK: - StateObject
    @StateObject var permissionManager: PermissionManager = PermissionManager()
    
    // MARK: - ObservedObject
        @ObservedObject var observer: AudioStreamObserver
    
        private var streamManager: AudioStreamManager
    
    
        init() {
            observer = AudioStreamObserver()
            streamManager = AudioStreamManager()
            streamManager.resultObservation(with: observer)
        }
    
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
                    StepLayoutView(
                        stepNumber: stepNumber,
                        currentStage: $currentStage
                    )
                    .tag(stepNumber)
                }
                
            }
            .onChange(of: currentStage) { num in
                stepMemory = num
            }
                        .onChange(of: observer.voiceCommand) {
                            result in
            
                            print(currentStage, result)
                            switch result {
                            case 1:
                                if currentStage < appController.courseInfo.totalStep {
                                    currentStage += 1
                                }
                            case -1:
                                if currentStage > 1 {
                                    currentStage -= 1
                                }
                            default:
                                break
                            }
                            print("changeed currentStage", currentStage)
                            observer.voiceCommand = 0
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
                AppDelegate.orientationLock = .landscape
            }
            .onDisappear {
                streamManager.stopEngine()
            }
        }
        .navigationBarHidden(true)
    }
}

struct StagePagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StepSlideView()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
