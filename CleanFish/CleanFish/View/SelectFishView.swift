//
//  SelectFishView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct SelectFishView: View {
    @EnvironmentObject var appController: AppController
    @Binding var selectedFish: Fish
    
    let lottieSize: CGFloat = UIScreen.main.bounds.size.width * 0.5
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Spacer()
                ForEach(Fish.allCases, id: \.rawValue) { fish in
                    HStack {
                        if fish.index % 2 == 1 {
                            Spacer()
                        }
                        Button {
                            selectedFish = fish
                            appController.showRecipeView()
                        } label: {
                            LottieView(fileName: "\(fish.rawValue)", animationSpeed: 1)
                        }
                        .frame(width: lottieSize, height: lottieSize)
                        
                        if fish.index % 2 == 0 {
                            Spacer()
                        }
                    }
                }
            }
            .padding(.bottom, 180)
            .padding(.horizontal, 30)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .transition(.move(edge: .bottom))
        .navigationBarHidden(true)
    }
}

struct SelectFishViewPreviewsContainer: View {
    @State var selectedFish: Fish = .flatfish
    
    var body: some View {
        SelectFishView(selectedFish: $selectedFish)
    }
}

struct SelectFishView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFishViewPreviewsContainer()
    }
}
