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
    
    @State private var selectedValue: String = "임시 텍스트"

    var body: some View {
        ZStack {
            VStack(spacing: 34) {
                VStack(alignment: .leading) {
                    Text("어떤 용도로\n\(selectedFish)를 손질하시나요?")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                }

                ZStack {
                    Image("Dish")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text(selectedValue)
                }
                .padding(.horizontal, 31)
                
                VStack(spacing: 22) {
                    ForEach(Recipe.allCases, id: \.rawValue) { recipe in
                        Button(recipe.rawValue) {
                            selectedValue = selectedFish + "_\(recipe.rawValue)"
                        }
                        .foregroundColor(.black)
                        .frame(height: 64)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke("AACBFD".toColor(alpha: 1), lineWidth: 2)
                        }
                    }
                }
                
                Button("뒤로가기") {
                    viewChangeValue.1.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            viewChangeValue.0.toggle()
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 36)
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
