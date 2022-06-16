//
//  File.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/14.
//

import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    typealias UIViewType = PlayerUIView
    
    let step: Int
    let courseName: String
    var isPlay: Bool
    
    init(courseName: String, step: Int, isPlay: Bool) {
        self.step = step
        self.courseName = courseName
        self.isPlay = isPlay
    }
    
    func makeUIView(context: Context) -> PlayerUIView {
        return PlayerUIView(frame: .zero,
                            courseName: courseName,
                            step: step)
    }
    
    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        isPlay ? uiView.playVideo() : uiView.pauseVideo()
    }
}
