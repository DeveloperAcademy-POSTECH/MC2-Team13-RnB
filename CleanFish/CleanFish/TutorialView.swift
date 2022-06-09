//
//  TutorialView.swift
//  CleanFish
//
//  Created by 진영재 on 2022/06/08.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        //생선손질 튜토리얼 뷰
        VStack {
            Text("손쉬운 기능 사용법")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .padding(9)
            VStack {
                Text("손질 중 불편하게 터치하지 마세요!")
                    .fontWeight(.medium)
                    .padding(.bottom, 1)
                HStack(spacing: 0) {
                    Text("이전").foregroundColor(Color("HighlightColor"))
                        .fontWeight(.medium)
                    Text("을 말하면 이전단계로, ")
                        .fontWeight(.medium)
                    Text("다음").foregroundColor(Color("HighlightColor"))
                        .fontWeight(.medium)
                    Text("을 말하면 다음 단계로 넘어갑니다.")
                        .fontWeight(.medium)
                }
                .font(.system(size: 17))
                .padding(.bottom, 8)
            }
            HStack(alignment: .bottom) {
                Image("rumor")
                    .renderingMode(.template)
                    .foregroundColor(Color("ManColor"))
                Text("이전")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                    .padding(.trailing, 40)

            }
            .padding(.bottom, 12)
            HStack(spacing: 4) {
                Image(systemName: "exclamationmark.circle")
                Text("음성인식 사용이 힘든 경우에는 화면을 좌우로 스와이프 해주세요!")
                    .fontWeight(.medium)
            }.font(.system(size: 16))
                .padding(.bottom, 10)
            //시작하기 버튼
            Button {
                print("권한")
            } label: {
                Text("시작하기")
                    .fontWeight(.medium)
                    .font(.system(size: 22))
                    .frame(width: 317, height: 52, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color("StartButton"))
                    .cornerRadius(10)
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
