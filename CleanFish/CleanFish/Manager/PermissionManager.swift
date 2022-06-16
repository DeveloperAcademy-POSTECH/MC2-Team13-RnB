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
    @Published var micPermission: Bool = false
    @Published var speechRecognitionPermission: Bool = false
    @Published var goToStagePagingView: Bool = false
    
    init() {
        micPermission = (AVAudioSession.sharedInstance().recordPermission == .granted)
        speechRecognitionPermission = (SFSpeechRecognizer.authorizationStatus() == .authorized)
    }
    
    deinit {
        print("deinit PermissionManager")
    }
    
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { permissionValue in
            self.micPermission = permissionValue
        }
    }
    
    func speechRecognition() {
        SFSpeechRecognizer.requestAuthorization { authStatus  in
            DispatchQueue.main.async {
                self.speechRecognitionPermission = (authStatus == .authorized)
                self.goToStagePagingView = true
            }
        }
    }
    
    func pauseMic() {
        
    }
    
    func requestPermission() {
        self.requestMicrophonePermission()
        self.speechRecognition()
    }
    
    func permissionState() -> Bool {
        return speechRecognitionPermission && micPermission
    }
}
