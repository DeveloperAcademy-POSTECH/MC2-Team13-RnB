//
//  Recipe.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import Foundation

enum Recipe: String, CaseIterable {
    case grilled
    case stewed
    case sashimi
    
    var value: String {
        switch self {
        case .grilled:
            return "구이"
        case .stewed:
            return "조림"
        case .sashimi:
            return "회"
        }
    }
}
