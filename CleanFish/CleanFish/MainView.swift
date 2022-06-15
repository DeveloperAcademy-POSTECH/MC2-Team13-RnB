//
//  MainView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//  버그 발생 전 파일입니다.

import SwiftUI

typealias ShowView = (fishView: Bool, recipeView: Bool)

struct MainView: View {
    @EnvironmentObject var appController: AppController         // 있다가 AppController 다시 확인하자.
    @State var selectedFish: Fish = .flatfish                   // enum Fish.flatfish
    @State var backgroudPosition = 0.0
    @State var isShowContinueAlert = false
    @State var goToStagePagingView = false
    @StateObject var ePopToRoot: PopToRoot = PopToRoot(popToRootBool: false)
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if !appController.isMemoryEmpty {  // courseMemory.isEmpty || stepMemory == 0 둘중 하나라도 메모리가 비어있으면 실행안함
                        NavigationLink("", isActive: $goToStagePagingView) { // isAcitve 가 true 일때 뷰이동
                            StagePagingView()
                        }
                        .hidden() // "" 뷰를 항상 숨김 (unconditionally)
                    }
                
                    LottieView(filename: "wave", animationSpeed: 1)
                        .animation(.linear(duration: 0.3), value: UUID()) //일정한 속도로 0.3 초 동안 이동한다. value 값이 변경될때만 애니메이션 실행
                        .offset(x: 0, y: appController.showView.fishView ? 0 : UIScreen.main.bounds.height * 0.7)
                            //true 일때 높이 0  / false 일때 UIScreen 의 높이의 0.7 만큼 showView의 타입이 (fishView: Bool, recipeView: Bool)
                    ZStack {
                        if self.appController.showView.fishView {
                            SelectFishView(selectedFish: $selectedFish)
                        }
                    }
                    ZStack {
                        if self.appController.showView.recipeView {
                            SelectRecipeView(selectedFish: $selectedFish)
                        }
                    }
                        //선택된 생선의 종류를 가지고 각 뷰로 넘어간다.
                }                                                            // 이어보기는 알랏의 제목줄
                .alert("이어보기", isPresented: $isShowContinueAlert) {     //$isShowContinueAlert == true 일때 자동으로 알랏 실행
                    VStack {
                        Button("취소", role: .cancel) {           //버튼의 행위를 role 인자로 미리 지정가능
                            appController.initBuffer()              //버튼을 눌렀을때 나타나는 기능
                        }
                        Button("확인", role: .none) {
                            DispatchQueue.main.async {
                                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                                           forKey: "orientation")               //비동기 처리로 가로로 화면 전환
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){              //0.3 초 이후에 스테이지 페이징뷰 값 트루
                                self.goToStagePagingView = true                                    //asyncAfterf를 쓰기 위해..?
                            }
                        }
                    }
                } message: {
                    Text("손질 중이던 생선이 있습니다.\n계속 보시겠습니까?")
                }
            }
            .onAppear {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                          forKey: "orientation")                            //세로로 기본 화면 고정
                print("appController.isMemoryEmpty \(appController.isMemoryEmpty)")
                if !appController.isMemoryEmpty {                                               //  isMemoryEmpty 의 appStorage값이 존재할 경우//
                    NetworkManager.shared                                                       // getMomery에서 코스 값을 불러온다음
                        .getTotalStep(courseName: appController.getMemory.courseID) { courseInfo in
                        if let courseInfo = courseInfo {                                       //  optional 언래핑
                            self.appController.courseInfo = courseInfo                             //코스값을 courseInfo에 대입
                            self.isShowContinueAlert = true                                           //이어보기 알럿을 띄운다.
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            .padding(.top)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .environmentObject(ePopToRoot)          //supply obeservableObject to subhierarchy
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
