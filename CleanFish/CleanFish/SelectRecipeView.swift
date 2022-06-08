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
                            selectedValue = "\(recipe.rawValue)"
                        }
                        .foregroundColor(.black)
                        .frame(height: 64)
                        .frame(maxWidth: .infinity)
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill((selectedValue == recipe.rawValue) ? "#AACBFD".toColor(alpha: 1) : .clear)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke("#AACBFD".toColor(alpha: 1), lineWidth: 2)
                            }
                        }
                    }
                }
                Button {
                    
                } label: {
                    Image(systemName: "arrow.forward.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor("#0344A5".toColor(alpha: 1))
                }
                
                .frame(width: 44, height: 44, alignment: .center)
                
                
                Spacer()
                
                Button {
                    viewChangeValue.1.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            viewChangeValue.0.toggle()
                        }
                    }
                } label: {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor("#3C3C43".toColor(alpha: 1))
                }
                .frame(width: 30, height: 20, alignment: .center)
                .padding(.bottom, 22)
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
