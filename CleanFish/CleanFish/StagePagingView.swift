//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    @EnvironmentObject private var appController: AppController
    
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
        TabView(selection: $currentStage) {
            ForEach(1...appController.courseInfo.totalStep, id: \.self) { stepNumber in
                VStack {
                    Button {
                        if permissionManager.permissionState() {
                            isVoiceFunctionOn.toggle()
                        } else {
                            isShowPermissionAlert = true
                        }
                    } label: {
                        Image(systemName: permissionManager.permissionState()
                              ? "mic.circle.fill"
                              : "mic.slash.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.primaryBlue)
                        .alert(isPresented: $isShowPermissionAlert) {
                            Alert(title: Text("음성 인식"),
                                  message: Text("기능을 사용하시려면 마이크 권한을 호용해주세요.\n확인을 누르면 설정으로 이동합니다"),
                                  primaryButton: .destructive(Text("취소")) { },
                                  secondaryButton: .cancel(Text("확인")) {
                                goAppSetting()
                            })
                        }
                    }
                    
                    Button {
                        appController.initBuffer()
                        appController.goToHome()
                    } label: {
                        Text("홈으로 갑니다.")
                    }
                    
                    Text("Current Step: \(stepNumber)")
                    
                    if stepNumber == appController.courseInfo.totalStep {
                        Button("첫단계로") {
                            currentStage = 1
                        }
                    }
                }
                .tag(stepNumber)
                .onAppear {
                    NetworkManager.shared.getStepInfo(course: appController.courseInfo,
                                                      stepNumber: stepNumber) { step in
                        print(step?.currentStep ?? 0)
                        print(step?.content ?? "")
                    }
                }
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
        .navigationBarHidden(true)
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
            StagePagingView()
                .previewInterfaceOrientation(.landscapeRight)
            //            StagePagingView()
            //                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
