//
//  VideoShowViewUikit.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/10.
//

import SwiftUI
import AVFoundation

class PlayerUIView: UIView {
    var playerLayer = AVPlayerLayer()
//    private var playerLooper: AVPlayerLooper?
    var player = AVPlayer()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, courseName: String, step: Int) {
        super.init(frame: frame)
        let URL = NetworkManager.shared.getVideoURL(courseName: courseName, step: step)
        print(URL.absoluteString, #function)
        player = AVPlayer(url: URL)
        player.preventsDisplaySleepDuringVideoPlayback = true
        player.automaticallyWaitsToMinimizeStalling = true
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        player.actionAtItemEnd = .none
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(rewindVideo(notification:)),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: player.currentItem)
//        player.play()
//        let URL = NetworkManager.shared.getVideoURL(courseName: courseName, step: step)
//        print(URL.absoluteString, #function)
        
        // 동영상 불러오기
        // let playerItem = AVPlayerItem(url: URL)
        
        // 동영상 플레이어 셋팅하기
        
        // let player = AVQueuePlayer(playerItem: playerItem)
//        playerLayer.player = player
//        playerLayer.videoGravity = .resizeAspectFill
//        layer.addSublayer(playerLayer)
        
        // 동영상 반복하기
        //        playerLooper = AVPlayerLooper(player: player, templateItem: player)
    }
    
//    func playVideo(courseName: String, step: Int) {
//        let URL = NetworkManager.shared.getVideoURL(courseName: courseName, step: step)
//        print(URL.absoluteString, #function)
//        player = AVPlayer(url: URL)
//        player.preventsDisplaySleepDuringVideoPlayback = true
//        playerLayer.player = player
//        playerLayer.videoGravity = .resizeAspectFill
//        layer.addSublayer(playerLayer)
//
//        player.actionAtItemEnd = .none
//        NotificationCenter
//            .default
//            .addObserver(self,
//                         selector: #selector(rewindVideo(notification:)),
//                         name: .AVPlayerItemDidPlayToEndTime,
//                         object: player.currentItem)
//        self.playVideo()
//    }
    
    func playVideo() {
        player.seek(to: .zero)
        player.playImmediately(atRate: 1)
    }
    
    func pauseVideo() {
        player.pause()
    }
    
    @objc
    func rewindVideo(notification: Notification) {
        playerLayer.player?.seek(to: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(courseName: "flatfish_sashimi", step: 1, isPlay: false)
    }
}
