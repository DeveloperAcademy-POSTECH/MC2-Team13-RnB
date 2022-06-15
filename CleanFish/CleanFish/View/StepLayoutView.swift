//
//  StepLayoutView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StepLayoutView: View {
    let stepNumber: Int
    
    // MARK: - EnvironmentObject
    @EnvironmentObject var appController: AppController
    
    // MARK: - State
    @State private var isVoiceFunctionOn = true
    @State private var isShowPermissionAlert = false
    @State private var isPlayVideo = true
    @State private var stepInfo: Step?
    
    // MARK: - Binding
    @Binding var goToHome: Bool
    @Binding var currentStage: Int
    
    // MARK: - StateObject
    @StateObject var permissionManager: PermissionManager = PermissionManager()
    
    func changeOrientation(to orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
    
    func goAppSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func attributedText(_ text: String) -> Text {
        var resultString = Text("")
        text.components(separatedBy: "(").forEach { firstSep in
            if firstSep.contains(")") {
                if let blueString = firstSep.components(separatedBy: ")").first {
                    resultString = resultString + Text(blueString).fontWeight(.semibold).foregroundColor(.primaryBlue)
                }
                if let blackString = firstSep.components(separatedBy: ")").last {
                    resultString = resultString + Text(blackString).fontWeight(.medium)
                }
            } else {
                resultString = resultString + Text(firstSep).fontWeight(.medium)
            }
        }
        return resultString
    }
    
    var body: some View {
        HStack(spacing: 24) {
            ZStack {
                // VideoView()
                VideoPlayerView(courseName: appController.courseInfo.courseName,
                              step: stepNumber,
                              isPlay: isPlayVideo)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(stepInfo?.currentStep ?? 0)/\(stepInfo?.totalStep ?? 0)")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill("CDCDCD".toColor(alpha: 1))
                            }
                    }
                }
                .padding()
            }
            .aspectRatio(7/5, contentMode: .fit)
            .cornerRadius(20)
            .padding(.top, 15)
            .padding(.leading, 20)
            .layoutPriority(1) // 값 높을 수록 순위 높음
            
            VStack(alignment: .leading, spacing: 0) {
                Text("\(stepInfo?.title ?? "")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 32)
                attributedText("\(stepInfo?.content ?? "")")
                    .font(.title3)
                    .padding(.top, 14)
                    .lineSpacing(5)
                Spacer()
                
                if stepNumber == appController.courseInfo.totalStep {
                    VStack(spacing: 15) {
                        Button {
                            currentStage = 1
                        } label: {
                            Text("1단계로")
                                .fontWeight(.medium)
                                .font(.title3)
                                .frame(height: 45, alignment: .center)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color("StartButton"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            appController.initBuffer()
                            appController.goToHome()
                            goToHome = false
                        } label: {
                            Text("홈으로")
                                .fontWeight(.medium)
                                .font(.title3)
                                .frame(height: 45, alignment: .center)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color("StartButton"))
                                .cornerRadius(10)
                        }
                    }
                } else {
                    HStack {
                        Spacer()
                        Button {
                            if permissionManager.permissionState() {
                                isVoiceFunctionOn.toggle()
                            } else {
                                isShowPermissionAlert = true
                            }
                        } label: {
                            Image(systemName: permissionManager.permissionState() && isVoiceFunctionOn
                                  ? "mic.circle.fill"
                                  : "mic.slash.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.primaryBlue)
                        }
                        .alert(isPresented: $isShowPermissionAlert) {
                            Alert(title: Text("음성 인식"),
                                  message: Text("기능을 사용하시려면 마이크 권한을 호용해주세요.\n확인을 누르면 설정으로 이동합니다."),
                                  primaryButton: .destructive(Text("취소")) { },
                                  secondaryButton: .cancel(Text("확인")) {
                                goAppSetting()
                            })
                        }
                        
                        //
                        Button {
                            appController.initBuffer()
                            appController.goToHome()
                            goToHome = false
                        } label: {
                            Image(systemName: "house.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primaryBlue)
                        }
                    }
                }
            }
            .layoutPriority(0)
        }
        .onChange(of: currentStage) { currentStep in
            isPlayVideo = (currentStep == stepNumber)
        }
        .onAppear {
            NetworkManager.shared.getStepInfo(course: appController.courseInfo,
                                              stepNumber: stepNumber) { step in
                stepInfo = step
            }
        }
        .navigationBarHidden(true)
    }
}

struct VideoView: View {
    var body: some View {
        Color.blue
    }
}

struct StageLayout75ViewPreviewContainer: View {
    @State private var currentStage: Int = 0
    @State private var goToHome: Bool = false
    
    var body: some View {
        StepLayoutView(stepNumber: 0,
                          goToHome: $goToHome,
                          currentStage: $currentStage)
    }
}

struct StageLayout75View_Previews: PreviewProvider {
    static var previews: some View {
        StageLayout75ViewPreviewContainer()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

