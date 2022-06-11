//
//  MainView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct MainView: View {
    @State var viewChangeValue: (Bool, Bool) = (true, false)// 0: Fish, 1: Recipe
    @State var selectedFish: Fish = .flatfish
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ZStack {
                        if self.viewChangeValue.0 {
                            SelectFishView(selectedFish: $selectedFish, viewChangeValue: $viewChangeValue)
                        }
                    }
                    ZStack {
                        if self.viewChangeValue.1 {
                            SelectRecipeView(selectedFish: $selectedFish, viewChangeValue: $viewChangeValue)
                        }
                    }
                }
            }
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
