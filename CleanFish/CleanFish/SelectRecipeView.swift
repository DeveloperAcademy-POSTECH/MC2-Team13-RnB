//
//  SelectRecipeView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct SelectRecipeView: View {
    @Binding var selectedFish: Fish
    @Binding var viewChangeValue: (Bool, Bool)
    
    @State private var selectedValue: String = "임시 텍스트"
    
    var body: some View {
        ZStack {
            VStack(spacing: 34) {
                VStack(alignment: .leading) {
                    Text("어떤 용도로\n\(selectedFish.value)를 손질하시나요?")
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(alignment: .leading)
                
                ZStack {
                    Image("Dish")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text(selectedValue)
                }
                .padding(.horizontal, 31)
                
                VStack(spacing: 22) {
                    ForEach(Recipe.allCases, id: \.rawValue) { recipe in
                        Button {
                            selectedValue = "\(recipe.value)"
                            NetworkManager.shared.getTotalStep(courseName: "\(selectedFish.rawValue)_\(recipe.rawValue)") { courseInfo in
                                print(courseInfo)
                                print(courseInfo?.totalStep ?? 0)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill((selectedValue == recipe.value) ? "#AACBFD".toColor(alpha: 1) : .clear)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke("#AACBFD".toColor(alpha: 1), lineWidth: 2)
                                Text(recipe.value)
                            }
                        }
                        .frame(height: 64)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        
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
        .animation(.linear(duration: 1), value: 0)
    }
}

struct SelectRecipeViewPreviewsContainer: View {
    @State var selectedFish: Fish = .flatfish
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
