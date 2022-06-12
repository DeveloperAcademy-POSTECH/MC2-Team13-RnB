//
//  StagePagingView.swift
//  CleanFish
//
//  Created by KimJS on 2022/06/06.
//

import SwiftUI

struct StagePagingView: View {
    @State private var currentStage: Int = 0
    @State var permissionManager: PermissionManager = PermissionManager()
    
    var body: some View {
        TabView(selection: $currentStage) {
            Button {
                // Go to Setting
            } label: {
                Text("Go To Red View")
            }
            .gesture(DragGesture())
            .tag(0)
            
            StageView1().tag(1)
            StageView2().tag(2)
            StageView3().tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .navigationBarHidden(true)
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
            StagePagingView(permissionManager: PermissionManager())
                .previewInterfaceOrientation(.landscapeRight)
//            StagePagingView()
//                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
