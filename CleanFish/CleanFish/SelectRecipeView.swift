//
//  SelectRecipeView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI

struct SelectRecipeView: View {
    // MARK: - State Property
    @State private var isShowOrientationAlert: Bool = false
    @State private var selectedRecipe: Recipe = .grilled
    @State private var goToTutorialPage: Bool = false
//    @State private var isLinkActivated: Bool = false
  
    // MARK: - Binding Property
    @Binding var selectedFish: Fish
    @Binding var showView: ShowView
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Button {
                        showView.recipeView.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                showView.fishView.toggle()
                            }
                        }
                    } label: {
                        Text("이전")
                            .font(.title3)
                            .foregroundColor("#4986E6".toColor(alpha: 1))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(alignment: .leading)
                    .padding(.horizontal, 15)
                }
                .frame(alignment: .leading)
                
                VStack(spacing: 34) {
                    Text("생선을 어떻게 드실 예정인가요??")
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                    
                    ZStack {
                        Image("Dish")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        Image("\(selectedFish.rawValue)_\(selectedRecipe.rawValue)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(25)
                    }
                    .padding(.horizontal, 31)
                    
                    VStack(spacing: 22) {
                        ForEach(Recipe.allCases, id: \.rawValue) { recipe in
                            Button {
                                selectedRecipe = recipe
//                                NetworkManager.shared.getTotalStep(courseName: "\(selectedFish.rawValue)_\(recipe.rawValue)") { courseInfo in
//                                    if let courseInfo = courseInfo {
//                                        NetworkManager.shared.getStepInfo(course: courseInfo, stepNumber: 2) { stepInfo in
//                                            print(stepInfo)
//                                        }
//                                    }
//                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill((selectedRecipe == recipe) ? "#AACBFD".toColor(alpha: 1) : .clear)
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
                        isShowOrientationAlert.toggle()
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor("#4986E6".toColor(alpha: 1))
                    }
                    .frame(width: 64, height: 64, alignment: .center)
                    .alert("\(selectedFish.value) \(selectedRecipe.value)", isPresented: $isShowOrientationAlert) {
                        VStack {
                            Button("취소", role: .cancel) {
                                
                            }
                            Button("확인", role: .none) {
                                DispatchQueue.main.async {
                                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                                              forKey: "orientation")
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    goToTutorialPage.toggle()
                                }
                            }
                        }
                    } message: {
                        Text("이대로 진행하시겠습니까?\n시작 시, 화면이 가로로 돌아갑니다.")
                    }
                    
                    NavigationLink("", isActive: $goToTutorialPage) {
                        TutorialView(goToTutorialPage: $goToTutorialPage, showView: $showView)
                    }
                    .hidden()
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 36)
            }
        }
        .transition(.opacity.animation(.linear))
        .animation(.linear(duration: 1), value: 0)
        .navigationBarHidden(true)
    }
}

struct SelectRecipeViewPreviewsContainer: View {
    @State var selectedFish: Fish = .flatfish
    @State var showView: ShowView = (true, false)
    
    var body: some View {
        SelectRecipeView(selectedFish: $selectedFish, showView: $showView)
    }
}

struct SelectRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRecipeViewPreviewsContainer()
    }
}
