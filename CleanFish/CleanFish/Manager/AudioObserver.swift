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
    var prepreSound: String = ""
    
    
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        // 최상의 음성만을 가져옵니다.
        guard let classification = result.classifications.first else { return }
        print("Classified Sound: \(classification.identifier)")
        DispatchQueue.main.async {
            self.currentSound = classification.identifier
            if classification.confidence >= 0.75 { // 올바르게 판단 한다는 기준 입니다.
            if (self.preSound == "이전"||self.preSound == "노이즈") && self.currentSound != "노이즈" {
                // classification 의 결과가 (다음, 이전) 혹은 (다음, 다음) 처럼 노이즈가 아닌 결과가 연속으로 나오는 경우
                // 단계가 분류 결과에 따라 계속 바뀌기 떄문에 바로 직전의 분류 결과가 "노이즈"인 경우에만 단계의 변화가 생기도록 했습니다.
                    if self.currentSound != self.preSound {
                        print(classification.confidence, classification.identifier)
                        self.voiceCommand = (self.currentSound == "다음") ? 1 : -1
                    }
                }
            }
            self.preSound = self.currentSound // 소리가 흐른다는 결과를 기록하기 위해 curr의 결과를 계속 prev 로 전달해줍니다.
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
