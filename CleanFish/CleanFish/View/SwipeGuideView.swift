//
//  SwipeGuideView.swift
//  CleanFish
//
//  Created by 진영재 on 2022/06/08.
//

import SwiftUI
// import UserNotifications

struct SwipeGuideView: View {
    // 권한에 대한 로직을 수행하는 변수
    @EnvironmentObject var appController: AppController
    @StateObject private var permissionManager: PermissionManager = PermissionManager()

    var body: some View {
        // 생선손질 튜토리얼 뷰
        VStack {
            Text("음성인식 사용이 어려운 상황이라면?")
                .foregroundColor(.textGray)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)
          
            GIFView(fileName: "swipe")
                .frame(width: 374, height: 160, alignment: .center)
            
            ZStack {
                NavigationLink("", isActive: $permissionManager.goToStagePagingView) {
                    StepSlideView()
                }
                .hidden()
                Button {
                    permissionManager.requestPermission()
//                    appController.initBuffer()
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

// struct SwipeGuideViewPreviewContainer: View {
//    @State var goToTutorialPage: Bool = true
//    @State var showView: ShowView = (false, true)
//
//    var body: some View {
//        SwipeGuideView(goToTutorialPage: $goToTutorialPage, showView: $showView)
//    }
// }
//
struct SwipeGuideView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeGuideView()
//        SwipeGuideViewPreviewContainer()
//            .previewInterfaceOrientation(.landscapeRight)
    }
}
