//
//  VideoShowViewUikit.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/10.
//

import SwiftUI
import AVFoundation

struct LoopingPlayer: UIViewRepresentable {
    let step: Int
    init(step: Int) {
        self.step = step
    }
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero, step: step)
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    
    init(frame: CGRect, step: Int) {
        super.init(frame: frame)
        
        let URL = NetworkManager.shared.getVideoURL(courseName: "flatfish_sashimi", step: step)
        
        // 동영상 불러오기
        let playerItem = AVPlayerItem(url: URL)
        
        // 동영상 플레이어 셋팅하기
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // 동영상 반복하기
//        player.actionAtItemEnd = .none
//        NotificationCenter.default.addObserver(self, selector:  #selector(rewindVideo(notification:)), name:
//                .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        // 동영상 재생하기
        player.play()
    }
    
//    @objc
//    func rewindVideo(notification: Notification) {
//        playerLayer.player?.seek(to: .zero)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = CGRect(x: 0, y: 15, width: 504, height: 360)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        LoopingPlayer(step: 1)
    }
}
