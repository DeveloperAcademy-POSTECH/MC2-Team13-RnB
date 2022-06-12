//
//  TutorialView1.swift
//  CleanFish
//
//  TutorialView1.swift
//  CleanFish
//
//  Created by 진영재 on 2022/06/12.
//

import SwiftUI

struct TutorialView1: View {
    var body: some View {
        NavigationView {
        VStack {
            HStack {
                Text("            ")
                Spacer()
            Text("손질 중 불편하게 터치하지 마세요!")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .padding(.bottom, 9)
                
                 Spacer()
                NavigationLink {
                    StageLayout75View(goToTutorialPage: $goToTutorialPage, viewChangeValue: $viewChangeValue, speechRecognitionPermission: $speechRecognitionPermission, micPermission: $micPermission)
                } label: {
                    Text("건너뛰기")
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                        .foregroundColor(Color("StartButton"))
                }
                

            }
            Text("gif")
                .frame(width: 493, height: 213, alignment: .center)
                .border(.blue, width: 3)

    // 다음 버튼
              NavigationLink {
                  TutorialView(isboolyes: <#T##Bool#>, micPermission: <#T##Bool#>, speechRecognitionPermission: <#T##Bool#>, goToTutorialPage: <#T##Binding<Bool>#>, viewChangeValue: <#T##Binding<(Bool, Bool)>#>)
                } label: {
                    Text("다음")
                        .fontWeight(.medium)
                        .font(.system(size: 22))
                        .frame(width: 377, height: 52, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color("StartButton"))
                        .cornerRadius(10)
                }
        }    .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
        }
    }
}

struct TutorialView1_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView1()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
