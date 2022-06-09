//
//  SelectFishView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct SelectFishView: View {
    @Binding var selectedFish: String
    @Binding var viewChangeValue: (Bool, Bool)
    
    var body: some View {
        ZStack {
            // Lottie View Code
            Color.gray
            // Fish
            VStack {
                ForEach(Fish.allCases, id: \.rawValue) {fish in
                    // 버튼의 위치는 실제 생선 이미지가 만들어졌을 때, 재배치
                    HStack {
                        Button {
                            selectedFish = fish.rawValue
                            viewChangeValue.0.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewChangeValue.1.toggle()
                            }
                        } label: {
                            // Fish Image Code
                            Text(fish.rawValue)
                        }
                    }
                }
            }
            .padding(.horizontal, 25)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .transition(.move(edge: .bottom))
        .animation(.linear(duration: 0.3), value: UUID())
    }
}

struct SelectFishViewPreviewsContainer: View {
    @State var selectedFish: String = ""
    @State var viewChangeValue: (Bool, Bool) = (true, false)

    var body: some View {
        SelectFishView(selectedFish: $selectedFish, viewChangeValue: $viewChangeValue)
    }
}

struct SelectFishView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFishViewPreviewsContainer()
    }
}
