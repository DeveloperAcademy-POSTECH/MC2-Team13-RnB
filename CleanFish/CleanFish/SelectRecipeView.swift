//
//  SelectRecipeView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct SelectRecipeView: View {
    @Binding var selectedFish: String
    @Binding var viewChangeValue: (Bool, Bool)

    var body: some View {
        ZStack {
            VStack {
                Text(selectedFish)
                Button("뒤로가기") {
                    viewChangeValue.1.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            viewChangeValue.0.toggle()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .transition(.opacity.animation(.linear))
        .animation(.linear(duration: 1), value: UUID())
    }
}

struct SelectRecipeViewPreviewsContainer: View {
    @State var selectedFish: String = ""
    @State var viewChangeValue: (Bool, Bool) = (true, false)

    var body: some View {
        SelectRecipeView(selectedFish: $selectedFish, viewChangeValue: $viewChangeValue)
    }
}

struct SelectRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRecipeViewPreviewsContainer()
    }
}
