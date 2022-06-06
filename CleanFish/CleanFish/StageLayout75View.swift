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
    var body: some View {
        HStack {
            VideoView()
                .frame(width: 7 * unitSize, height: 5 * unitSize)
                .cornerRadius(cornerSize)
                .padding(.top)
                .padding(.leading, 20)
            Spacer()
        }
    }
}

struct VideoView: View {
    var body: some View {
        Color.blue
    }
}

struct StageLayout75View_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StageLayout75View()
                .previewInterfaceOrientation(.landscapeRight)
            StageLayout75View()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
