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
    
    init() {
          micPermission = (AVAudioSession.sharedInstance().recordPermission == .granted)
          speechRecognitionPermission = (SFSpeechRecognizer.authorizationStatus() == .authorized)
      }
      
      func requestMicrophonePermission() {
          AVAudioSession.sharedInstance().requestRecordPermission { permissionValue in
              self.micPermission = permissionValue
          }
//          if AVAudioSession.sharedInstance().recordPermission == .denied {
//              AVAudioSession.sharedInstance().requestRecordPermission { permissionValue in
//                  self.micPermission = permissionValue
//              }
//          }
      }
      
      func speechRecognition() {
          SFSpeechRecognizer.requestAuthorization { authStatus  in
              DispatchQueue.main.async {
                  self.speechRecognitionPermission = (authStatus == .authorized)
                  self.goToStagePagingView = true
              }
//          if SFSpeechRecognizer.authorizationStatus() == .denied {
//              SFSpeechRecognizer.requestAuthorization { authStatus  in
//                  DispatchQueue.main.async {
//                      self.speechRecognitionPermission = (authStatus == .authorized)
//                      self.goToStagePagingView = true
//                  }
//              }
//          } else {
//              self.goToStagePagingView = true
              
          }
      }
      
      func requestPermission() {
          self.requestMicrophonePermission()
          self.speechRecognition()
      }
      
      func permissionState() -> Bool {
          return speechRecognitionPermission && micPermission
      }
  }
