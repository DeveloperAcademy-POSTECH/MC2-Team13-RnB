//
//  LottieView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView       //  typealias 로 UIViewType 이라는 타입 별칭 생성
    var filename: String
    var animationSpeed: CGFloat

    init(filename: String, animationSpeed: CGFloat = 1) {       //animationSpeed 는 기본값 1(CGFloat 로 고정 -> 새값으로 초기화 하면 변경가능)
        self.filename = filename                                // 외부에서 선언한 filename 값으로 filename 을 초기화
        self.animationSpeed = animationSpeed
    }
    
    func createAnimationView(completeHandler: (AnimationView) -> Void) -> AnimationView {
        let animationView: AnimationView = AnimationView()
        completeHandler(animationView)
        return animationView                                        // 이건 왜 필요한거죠?
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
