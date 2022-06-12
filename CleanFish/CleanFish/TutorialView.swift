//
//  TutorialView.swift
//  CleanFish
//
//  Created by 진영재 on 2022/06/08.
//

import SwiftUI
import AVFoundation
import UserNotifications

struct TutorialView: View {
    @State var isboolyes = false
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool) -> Void in
            if granted {
                print("Mic: 권한 허용")
                request2()
            } else {
                print("Mic: 권한 거부")
                request2()
            }
        })
    }
    
    func request2() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didallow, error in print(didallow) } )
    }
    
    //https://lucidmaj7.tistory.com/23
    var body: some View {
        // 생선손질 튜토리얼 뷰
        VStack {
            Text("손질 중 불편하게 터치하지 마세요!")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .padding(.bottom, 9)
            VStack {
                HStack(spacing: 0) {
                    Text("이전")
                        .fontWeight(.bold)
                    Text("을 말하면 이전단계로, ")
                        .fontWeight(.medium)
                    Text("다음")
                        .fontWeight(.bold)
                    Text("을 말하면 다음 단계로 넘어갑니다.")
                        .fontWeight(.medium)
                }
                .font(.system(size: 17))
                .padding(.bottom, 2)
                Text("음성인식 사용이 힘든 경우에는 화면을 좌우로 스와이프 해주세요.")
                    .padding(.bottom, 10)
            }
            HStack(alignment: .bottom) {
                Image("rumor")
                    .renderingMode(.template)
                    .foregroundColor(Color("ManColor"))
                Text("  이전 / 다음")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
            }
            .padding(.bottom, 12)
            // 시작하기 버튼
            NavigationLink(destination: StageLayout75View(), isActive: $isboolyes) {
                Text("시작하기")
                    .fontWeight(.medium)
                    .font(.system(size: 22))
                    .frame(width: 377, height: 52, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color("StartButton"))
                    .cornerRadius(10)
            }
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                      forKey: "orientation")
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}
struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
