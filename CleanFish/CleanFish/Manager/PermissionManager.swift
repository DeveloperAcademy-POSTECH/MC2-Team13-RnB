//
//  PermissionManager.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/12.
//

import Foundation
import AVFoundation
import Speech

class PermissionManager: ObservableObject {
    @Published var speechRecognitionPermission: Bool = false
    @Published var micPermission: Bool = false
    @Published var goToStagePagingView: Bool = false
    
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { permissionValue in
            self.micPermission = permissionValue
        }
    }
    
    func speechRecognition() {
        SFSpeechRecognizer.requestAuthorization { authStatus  in
            self.speechRecognitionPermission = (authStatus == .authorized)
            self.goToStagePagingView = true
        }
    }
    
    func requestPermission() {
        requestMicrophonePermission()
        speechRecognition()
    }
    
    func permissionState() -> Bool {
        return speechRecognitionPermission && micPermission
    }
}
