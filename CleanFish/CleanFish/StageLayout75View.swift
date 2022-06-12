//
//  StageLayout75View.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

let unitSize: CGFloat = 72
let cornerSize: CGFloat = 20

struct StageLayout75View: View {
    @Binding var isLinkActivated: Bool
    @Binding var viewChangeValue: (Bool, Bool)
    
    var body: some View {
        HStack(spacing: 24) {
            VideoView()
                .frame(width: 7 * unitSize, height: 5 * unitSize)
                .cornerRadius(cornerSize)
                .padding(.top, 15)
                .padding(.leading, 20)
            VStack(alignment: .leading, spacing: 0) {
                Text("제목이들어갑니다람")
                    .font(.title)
                    .bold()
                    .border(.pink)
                    .padding(.top, 32)
                Text("본문이 들어갑니다 여러 줄의 본문이 들어갈 예정입니다 어떻게 들어갈지 궁금하시죠? 안궁금하다고요? 그럼 지금부터 궁금해하세요")
                    .font(.title2)
                    .padding(.top, 14)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        if UIDevice.current.orientation.isLandscape {
                            changeOrientation(to: .portrait)
                            self.isLinkActivated.toggle()
                            self.viewChangeValue.0.toggle()
                            self.viewChangeValue.1.toggle()
                        }
                    }, label: {
                        Image(systemName: "house.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.homeBlue)
                    })
                }
            }
        }.navigationBarHidden(true)
    }
}

.navigationBarTitle("") + .navigationBarBackButtonHidden(true) == navigationBarHidden(true)

func changeOrientation(to orientation: UIInterfaceOrientation) {
    UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
}

struct VideoView: View {
    var body: some View {
        Color.blue
    }
}

struct StageLayout75ViewPreviewContainer: View {
    @State var isLinkActivated: Bool = true
    @State var viewChangeValue: (Bool, Bool) = (false, true)
    
    var body: some View {
        StageLayout75View(isLinkActivated: $isLinkActivated, viewChangeValue: $viewChangeValue)
    }
}

struct StageLayout75View_Previews: PreviewProvider {
    static var previews: some View {
        StageLayout75ViewPreviewContainer()
    }
}

