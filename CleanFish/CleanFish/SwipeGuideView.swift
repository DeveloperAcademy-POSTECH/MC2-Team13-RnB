//
//  SwipeGuideView.swift
//  CleanFish
//
//  Created by 진영재 on 2022/06/08.
//

import SwiftUI
//import UserNotifications

struct SwipeGuideView: View {
    // 권한에 대한 로직을 수행하는 변수
    @StateObject private var permissionManager: PermissionManager = PermissionManager()
    
    @Binding var goToTutorialPage: Bool
    
    let courseInfo: RecipeVO
    
    // 단계중에 홈화면으로 돌아가는 기능을 위해 있는 변수
//    @Binding var goToTutorialPage: Bool
//    @Binding var showView: ShowView

    var body: some View {
        // 생선손질 튜토리얼 뷰
        VStack {
            Text("음성인식 사용이 어려운 상황이라면?")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .padding(.bottom, 9)
            
            GIFView(fileName: "swipe")
//            Text("gif")
                .frame(width: 493, height: 213, alignment: .center)
//                .border(.blue, width: 3)
            
            ZStack {
                NavigationLink("", isActive: $permissionManager.goToStagePagingView) {
                    StagePagingView(goToTutorialPage: $goToTutorialPage, courseInfo: self.courseInfo)
                        .environmentObject(permissionManager)
                }
                .hidden()
                Button {
                    permissionManager.requestPermission()
                } label: {
                    Text("시작하기")
                        .fontWeight(.medium)
                        .font(.system(size: 22))
                        .frame(width: 377, height: 52, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color("StartButton"))
                        .cornerRadius(10)
                }
            }
            
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                      forKey: "orientation")
        }
        .navigationBarHidden(true)
    }
}

//struct SwipeGuideViewPreviewContainer: View {
//    @State var goToTutorialPage: Bool = true
//    @State var showView: ShowView = (false, true)
//
//    var body: some View {
//        SwipeGuideView(goToTutorialPage: $goToTutorialPage, showView: $showView)
//    }
//}
//
//struct SwipeGuideView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwipeGuideViewPreviewContainer()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
