//
//  AudioManger.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/14.
//

import Foundation
import AVFoundation
import SoundAnalysis

class AudioStreamManager {
    
    private var engine: AVAudioEngine?
    private var inputBus: AVAudioNodeBus?
    private var micInputFormat: AVAudioFormat?
    private var streamAnalyzer: SNAudioStreamAnalyzer?
    private var classifyRequest: SNClassifySoundRequest?
    private var resultObserver = AudioStreamObserver()
    
    init() {
        print("=======================================")
        print("AudioStreamManager")
        print("=======================================")
        engine = AVAudioEngine()
        
        // microphone audio bus 값을 셋팅하고 이 포맷값을 기억합니다.
        inputBus = AVAudioNodeBus(0)
        guard let inputBus = inputBus else {
            fatalError()
        }
        
        micInputFormat = engine?.inputNode.inputFormat(forBus: inputBus)
        
        guard let micInputFormat = micInputFormat else {
            fatalError("Could not retrieve microphone input format")
        }
        startEngine()
        
        // audio format값과 함께 sound stream analyzer을 아나셜라이징 해줍니다
        streamAnalyzer = SNAudioStreamAnalyzer(format: micInputFormat)
        
        // custom sound classifier을 setup합니다.
        classifierSetup()
    }
    
    deinit {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
        print("AudioStreamManager")
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    }
    
    public func resultObservation(with observer: SNResultsObserving) {
        // observer를 추가합니다.
        guard let classifyRequest = classifyRequest else {
            fatalError("Could not setup the classification request")
        }
        guard let streamAnalyzer = streamAnalyzer else {
            fatalError("Could not initializer stream analyzer")
        }
        
        do {
            try streamAnalyzer.add(classifyRequest, withObserver: observer)
        }
        
        catch {
            fatalError("Could not initializer observer for the sound classification results: \(error.localizedDescription)")
        }
        
    }
    
    private func classifierSetup() {
        let defaultConfig = MLModelConfiguration()
        let soundClassifier = try? RnBSoundClassifier(configuration: defaultConfig)
        
        guard let soundClassifier = soundClassifier else {
            fatalError("Could not instantiate sound classifier")
        }
        classifyRequest?.windowDuration = CMTime(value: 975, timescale: 1000)
        classifyRequest?.overlapFactor = 0.5
        
        classifyRequest = try? SNClassifySoundRequest(mlModel: soundClassifier.model)
    }
    
    func stopEngine() {
        guard let classifyRequest = classifyRequest else {
            fatalError("Could not setup the classification request")
        }
        guard let streamAnalyzer = streamAnalyzer else {
            fatalError("Could not initializer stream analyzer")
        }
        guard let engine = engine else {
            fatalError("Could not instantiate audio engine")
        }
        guard let inputBus = inputBus else {
            fatalError("Failed to retrieve input bus")
        }
        
        
        streamAnalyzer.remove(classifyRequest)
        self.engine?.pause()
        self.engine?.attachedNodes.first?.auAudioUnit.stopHardware()
        self.engine?.inputNode.removeTap(onBus: 0)
    
        print(engine.attachedNodes.first?.auAudioUnit)
        print(engine.attachedNodes.first?.auAudioUnit.isRunning)
    }
    
    func startEngine() {
        guard let engine = engine else {
            fatalError("Could not instantiate audio engine")
        }
        guard let inputBus = inputBus else {
            fatalError("Failed to retrieve input bus")
        }
        guard let micInputFormat = micInputFormat else {
            fatalError("Failed to retrieve input format")
        }
        do {
            engine.inputNode.installTap(onBus: inputBus, bufferSize: 150,
                                        format: micInputFormat, block: analyzeAudio(buffer:at:))
            try engine.attachedNodes.first?.auAudioUnit.startHardware()
            print("engine.attachedNodes.first?.auAudioUnit.isRunning")
            print(engine.attachedNodes.first?.auAudioUnit.isRunning)
            try engine.start()
        } catch {
            fatalError("Unable to start audio engine: \(error.localizedDescription)")
        }
        
    }
    
    public func getStreamPublisher() -> Optional<SNAudioStreamAnalyzer>.Publisher {
        return self.streamAnalyzer.publisher
    }
    public func analyzeAudio(buffer: AVAudioPCMBuffer, at time: AVAudioTime) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.streamAnalyzer!.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
    }
}
