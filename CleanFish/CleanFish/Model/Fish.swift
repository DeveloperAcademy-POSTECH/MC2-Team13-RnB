//
//  Fish.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/06.
//

import Foundation

enum Fish: String, CaseIterable {
    case flatfish
    case mackerel
    //    case cutlassfish
    
    var value: String {
        switch self {
        case .flatfish:
            return "광어"
        case .mackerel:
            return "고등어"
            //        case .cutlassfish:
            //            return "갈치"
        }
    }
    
    var index: Int {
        switch self {
        case .flatfish:
            return 0
        case .mackerel:
            return 1
        }
    }
}
