//
//  SelectFishView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct SelectFishView: View {
    @Binding var selectedFish: Fish
    @Binding var viewChangeValue: (Bool, Bool)
    
    var body: some View {
        ZStack {
            LottieView(filename: "wave", animationSpeed: 1)
            VStack(spacing: 20) {
                ForEach(Fish.allCases, id: \.rawValue) {fish in
                    // 버튼의 위치는 실제 생선 이미지가 만들어졌을 때, 재배치
                    HStack {
                        Button {
                            selectedFish = fish
                            viewChangeValue.0.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewChangeValue.1.toggle()
                            }
                        } label: {
                            // Fish Image Code
                            Text(fish.value)
                        }
                    }
                }
            }
            .padding(.horizontal, 25)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .transition(.move(edge: .bottom))
        .animation(.linear(duration: 0.3), value: UUID())
        .navigationBarHidden(true)
    }
}

struct SelectFishViewPreviewsContainer: View {
    @State var selectedFish: Fish = .flatfish
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
