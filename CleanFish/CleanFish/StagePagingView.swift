//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    @State private var currentStage: Int = 0
    @State var permissionManager: PermissionManager = PermissionManager()
    @State private var alretShowing = false
    
    // MARK: - [애플리케이션 설정창 이동 실시 : 권한 거부 시]
    func goAppSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var body: some View {
        TabView(selection: $currentStage) {
            Button {
                alretShowing = true
                // Go to Setting
            }
        label: {
            if !permissionManager.permissionState()  {
                Image(systemName: "mic.slash.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primaryBlue)
                    .alert(isPresented: $alretShowing) {
                                           Alert(title: Text("음성인식"), message: Text("음성 권한을 위해서 설정으로 이동합니다"), primaryButton: .destructive(Text("취소"), action: {
                                               alretShowing.toggle()
                                           }), secondaryButton: .cancel(Text("확인"),
                                                                action: {
                                               goAppSetting()
                                           }))
                                       
                    }
            } else {
                Image(systemName: "mic.circle.fill")
             
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primaryBlue)
                    .alert(isPresented: $alretShowing) {
                                           Alert(title: Text("음성인식"), message: Text("음성 권한을 위해서 설정으로 이동합니다"), primaryButton: .destructive(Text("취소"), action: {
                                               alretShowing.toggle()
                                           }), secondaryButton: .cancel(Text("확인"),
                                                                action: {
                                               goAppSetting()
                                           }))
                                       
                    }
                    
                
            }
            }
            .gesture(DragGesture())
            .tag(0)
            
            StageView1().tag(1)
            StageView2().tag(2)
            StageView3().tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
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
            StagePagingView(permissionManager: PermissionManager())
                .previewInterfaceOrientation(.landscapeRight)
//            StagePagingView()
//                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
