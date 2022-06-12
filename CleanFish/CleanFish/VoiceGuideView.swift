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

    // 선택한 생선과 손질 방법을 가지고 있는 변수
    let courseInfo: RecipeVO
    
    init(courseInfo: RecipeVO) {
        self.courseInfo = courseInfo
    }
    
    var body: some View {
        VStack {
            ZStack {
                Text("손질 중 불편하게 터치하지 마세요!")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .padding(.bottom, 9)
                HStack {
                    Spacer()
                   if !isGuideFirst {
                       NavigationLink {
                           Text("")
                       } label: {
                           Text("건너뛰기")
                               .font(.system(size: 22))
                               .fontWeight(.medium)
                               .foregroundColor(Color("StartButton"))
                       }
                   }
                }
            }
            
            Text("gif")
                .frame(width: 493, height: 213, alignment: .center)
                .border(.blue, width: 3)

    // 다음 버튼
              NavigationLink {
                  SwipeGuideView()
//                  Text("SwipeGuideView")
//                      .navigationBarHidden(true)
//                  SwipeGuideView(isboolyes: <#T##Bool#>,
//                               micPermission: <#T##Bool#>,
//                               speechRecognitionPermission: <#T##Bool#>,
//                               goToTutorialPage: <#T##Binding<Bool>#>,
//                               showView: <#T##Binding<(Bool, Bool)>#>)
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
        .onDisappear {
            isGuideFirst = false
        }
        .navigationBarHidden(true)
    }
}

struct VoiceGuideView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceGuideView(courseInfo: RecipeVO())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
