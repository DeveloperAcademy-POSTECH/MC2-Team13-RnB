//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    @State private var currentStage: Int = 0
    var body: some View {
        TabView(selection: $currentStage) {
            StageView1().tag(0)
            StageView2().tag(1)
            StageView3().tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct StageView1: View {
    var body: some View {
        Color.red
    }
}

struct StageView2: View {
    var body: some View {
        Color.blue
    }
}

struct StageView3: View {
    var body: some View {
        Color.green
    }
}

struct StagePagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StagePagingView()
                .previewInterfaceOrientation(.landscapeRight)
            StagePagingView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
