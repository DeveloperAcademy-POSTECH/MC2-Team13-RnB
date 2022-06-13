//
//  VideoView.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/10.
//

// import SwiftUI
// import AVKit
//
// struct VideoShowView: View {
//    @State var player = AVPlayer(url: URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
//    var body: some View {
//        VStack {
//            VideoPlayer(player: $player).frame(height: UIScreen.main.bounds.height / 3.5)
//            Spacer()
//        }
//        .background(Color.black.edgesIgnoringSafeArea(.all))
//        .onAppear {
//            self.player.play()
//        }
//    }
// }
//
//
// struct VideoPlayer: UIViewControllerRepresentable {
//    @Binding var player: AVPlayer
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) ->
//        AVPlayerViewController {
//        let controller = AVPlayerViewController()
//            controller.player = player
//            controller.showsPlaybackControls = false
//            return controller
//    }
//
//    func updateUIViewController(_ uiViewController: AVPlayerViewController,
//                                    context: UIViewControllerRepresentableContext<VideoPlayer>) {
//
//    }
//
// }
