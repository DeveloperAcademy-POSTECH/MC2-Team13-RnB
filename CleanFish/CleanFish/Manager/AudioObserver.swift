//
//  AudioObserver.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/14.
//

import Foundation
import SoundAnalysis

class AudioStreamObserver: NSObject, SNResultsObserving, ObservableObject {
    @Published var isCorrectCommand: Bool = false
    @Published var topResults: [SNClassification] = []
    @Published var count: Int = 0
    @Published var voiceCommand: Int = 0
    var currentSound: String = ""
    var preSound: String = ""
    
   
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        // 최상의 음성만을 가져옵니다.
        guard let classification = result.classifications.first else { return }
        print("Classified Sound: \(classification.identifier)")
        DispatchQueue.main.async {
            self.currentSound = classification.identifier
            if self.currentSound != "노이즈" {
                if classification.confidence >= 0.6 {
                    print(classification.confidence, classification.identifier)
                    self.voiceCommand = (self.currentSound == "다음") ? 1 : -1
                }
            }
//            print(result.classifications.first?.identifier ?? "")
//            print(self.preSound, self.currentSound)
//            self.currentSound = result.classifications.first
//            if self.preSound != "노이즈" {
//                self.isCorrectCommand = (self.preSound == self.currentSound)
//                if self.isCorrectCommand {
//                    self.voiceCommand = (self.currentSound == "다음") ? 1 : -1
//                }
//            }
//
//            self.preSound = self.currentSound
            self.topResults = Array(result.classifications[0...2])
            print(self.topResults)
        }
        
    }
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("Sound analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("Sound analysis request completed succesfully!")
    }
}
