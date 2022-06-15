//
//  VoiceGuideView.swift
//  CleanFish
//
//  VoiceGuideView.swift
//  CleanFish
//
//  Created by 진영재 on 2022/06/12.
//

import SwiftUI

struct VoiceGuideView: View {
    // VoiceGuideView를 보는게 처음인지 확인하는 변수
    @AppStorage("IS_GUIDE_FIRST") private var isGuideFirst: Bool = true
    @AppStorage("COURSE_NAME_BUFFER") var courseMemory = ""
    
    @EnvironmentObject var appController: AppController
    @EnvironmentObject var ePopToRoot: PopToRoot
    
    let selectedCourse: String
    
    init(selectedCourse: String) {
        self.selectedCourse = selectedCourse
    }
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Text("손질 중 불편하게 터치하지 마세요!")
                    .foregroundColor(.textGray)
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Spacer()
                    if !isGuideFirst {
                        NavigationLink {
                            StepSlideView()
                        } label: {
                            Text("건너뛰기")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(Color("StartButton"))
                        }
                    }
                }
            }
            .padding(.top, 15)
            
            GIFView(fileName: "voicecontrol")
                .frame(width: 374, height: 160, alignment: .center)
            
            // 다음 버튼
            NavigationLink {
                SwipeGuideView()
            } label: {
                Text("다음")
                    .fontWeight(.medium)
                    .font(.system(size: 22))
                    .frame(width: 377, height: 52, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color("StartButton"))
                    .cornerRadius(10)
            }
        }
        .onAppear {
            NetworkManager.shared
                .getTotalStep(courseName: selectedCourse) { courseInfo in
                    if let courseInfo = courseInfo {
                        self.appController.courseInfo = courseInfo
                        self.courseMemory = courseInfo.courseName
                    }
                }
        }
        .onDisappear {
            isGuideFirst = false
        }
//        .navigationBarHidden(true)
    }
}

struct VoiceGuideView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceGuideView(selectedCourse: "")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
