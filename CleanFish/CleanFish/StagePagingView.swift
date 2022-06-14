//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    // MARK: - EnvironmentObject
    //@EnvironmentObject var permissionManager: PermissionManager
    
    // MARK: - State property
    @State private var currentStage: Int = 0
    @State private var stepInfo: Step?
    
    // MARK: - Binding property
    @Binding var goToTutorialPage: Bool
    @Binding var showView: ShowView
    
    // MARK: - let property
    let courseInfo: RecipeVO
    
    // MARK: - ReceipVO, Step properties(comment)
    /*
     struct RecipeVO: Codable {
     var id: UUID
     var courseName: String
     var totalStep: Int
     
     struct Step: Codable {
     var courseID: UUID  코스의 ID
     var currentStep: Int  현재 단계
     var totalStep: Int  총 단계
     var title: String  현재 단계의 제목
     var content: String  현재 단계의 내용
     }
     */
    
    var body: some View {
        TabView(selection: $currentStage) {
            ForEach(0..<courseInfo.totalStep, content: { tagNumber in
                StageView0(goToTutorialPage: $goToTutorialPage, showView: $showView, textTopic: (self.stepInfo ?? Step()).title, textBody: (self.stepInfo ?? Step()).content)
                .tag(tagNumber)
                .onAppear(perform: {
                    NetworkManager.shared.getStepInfo(course: courseInfo, stepNumber: (self.currentStage + 1)) { stepInfo in
                        if let stepInfo = stepInfo {
                            self.stepInfo = stepInfo
                        }
                    }
                })
            })
        }
        .navigationBarHidden(true)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct StageView0: View {
    // MARK: - EnvironmentObject
    @EnvironmentObject var permissionManager : PermissionManager
    // MARK: - Binding property
    @Binding var goToTutorialPage: Bool
    @Binding var showView: ShowView
    
    // MARK: - let property
    let textTopic: String
    let textBody: String
    
    func changeOrientation(to orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                Image("staticwave")
                    .resizable()
                    .ignoresSafeArea()
            }
            HStack(spacing: 24) {
                VideoView()
                    .frame(width: 7 * unitSize, height: 5 * unitSize)
                    .cornerRadius(cornerSize)
                    .padding(.top, 15)
                    .padding(.leading, 20)
                VStack(alignment: .leading, spacing: 0) {
                    Text(self.textTopic)
                        .font(.title)
                        .bold()
                        .border(.pink)
                        .padding(.top, 32)
                    Text(self.textBody)
                        .font(.title2)
                        .padding(.top, 14)
                    Spacer()
                    HStack {
                        Spacer()
                        if permissionManager.permissionState() {
                            IconImageView("mic.circle.fill")
                        } else {
                            IconImageView("mic.slash.circle")
                        }
                        Button(action: {
                            if UIDevice.current.orientation.isLandscape {
                                changeOrientation(to: .portrait)
                                self.goToTutorialPage.toggle()
                                self.showView.fishView.toggle()
                                self.showView.recipeView.toggle()
                            }
                        }
                               , label: {
                            IconImageView("house.circle.fill")
                        })
                    }
                }
            }
        }
    }
}

struct IconImageView: View {
    let name: String
    init(_ name: String) {
        self.name = name
    }
    var body: some View {
        Image(systemName: self.name)
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(.primaryBlue)
    }
}

struct StagePagingViewPreviewContainer: View {
    @State var goToTutorialPage: Bool = true
    @State var showView: ShowView = (true, false)
    let courseInfo = RecipeVO()
    
    var body: some View {
        StagePagingView(goToTutorialPage: $goToTutorialPage, showView: $showView, courseInfo: self.courseInfo)
    }
}

struct StagePagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StagePagingViewPreviewContainer()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
