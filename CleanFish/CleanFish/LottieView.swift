//
//  LottieView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    var animationSpeed: CGFloat

    init(filename: String, animationSpeed: CGFloat = 1) {
        self.filename = filename
        self.animationSpeed = animationSpeed
    }

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIViewType {
        let view: UIView = UIView(frame: .zero)
        let animationView: AnimationView = AnimationView()
        animationView.animation = Animation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = animationSpeed
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {

    }

}
