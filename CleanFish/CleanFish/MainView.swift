//
//  MainView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

typealias ShowView = (fishView: Bool, recipeView: Bool)

struct MainView: View {
    @State var showView: ShowView = (true, false)// 0: Fish, 1: Recipe
    @State var selectedFish: Fish = .flatfish
    @State var backgroudPosition = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    LottieView(filename: "wave2", animationSpeed: 1)
                        .animation(.linear(duration: 0.3), value: UUID())
                        .offset(x: 0, y: showView.fishView ? 0 : UIScreen.main.bounds.height * 0.7)
                    ZStack {
                        if self.showView.fishView {
                            SelectFishView(selectedFish: $selectedFish, showView: $showView)
                        }
                    }
                    ZStack {
                        if self.showView.recipeView {
                            SelectRecipeView(selectedFish: $selectedFish, showView: $showView)
                        }
                    }
                }
            }
            .onAppear {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                          forKey: "orientation")
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            .padding(.top)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
