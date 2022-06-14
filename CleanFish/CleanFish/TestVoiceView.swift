//
//  TestVoiceView.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/14.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var observer: AudioStreamObserver
    @State var count: Int = 0
    @State var text: String = ""
    private var streamManager: AudioStreamManager
    
    init() {
        observer = AudioStreamObserver()
        streamManager = AudioStreamManager()
        streamManager.resultObservation(with: observer)
    }
    var body: some View {
        VStack {
            Spacer()
            Text(observer.isCorrectCommand ? "다음또는이전" : "몰라요")
                    .padding()
            Text("\(observer.count)")
        
            Spacer()
               
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

