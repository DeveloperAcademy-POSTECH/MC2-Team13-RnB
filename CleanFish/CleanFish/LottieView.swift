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
    
    func createAnimationView(completeHandler: (AnimationView) -> Void) -> AnimationView {
        let animationView: AnimationView = AnimationView()
        completeHandler(animationView)
        return animationView
    }

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIViewType {
        let view: UIView = UIView(frame: .zero)
        
        let _: AnimationView = createAnimationView {
            $0.animation = Animation.named(filename)
            $0.contentMode = .scaleAspectFit
            $0.loopMode = .loop
            $0.backgroundBehavior = .pauseAndRestore
            $0.animationSpeed = animationSpeed
            $0.play()
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalTo: view.widthAnchor),
                $0.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
//        guard let animationView = uiView.subviews.first as? AnimationView else {
//            print("animationView")
//            return
//        }
//        print(animationView)
//        animationView.play()
    }

}
