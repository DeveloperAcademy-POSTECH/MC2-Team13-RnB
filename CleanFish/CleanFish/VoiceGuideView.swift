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
//    @StateObject private var permissionManager: PermissionManager = PermissionManager()
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
                          
                           StagePagingView(permissionManager: PermissionManager())
                       } label: {
                           Text("건너뛰기")
                               .font(.system(size: 22))
                               .fontWeight(.medium)
                               .foregroundColor(Color("StartButton"))
                       }
                   }
                }
            }
           
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
