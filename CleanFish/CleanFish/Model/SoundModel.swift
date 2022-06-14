//
//  SoundModel.swift
//  CleanFish
//
//  Created by Yoonjae on 2022/06/14.
//

import Foundation
import CoreML

class RTSoundClassifier {
    private var model: MySoundClassifier?
    init() {
        // 앱내에 있는 모델을 가져온다.
        model = try? MySoundClassifier()
    }
}

