//
//  NetworkVO.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/11.
//

import Foundation

// Recipe Value Object
struct RecipeVO: Codable {
    var id: UUID
    var courseName: String
    var totalStep: Int
    
    init(id: UUID = UUID(), courseName: String = "", totalStep: Int = 0) {
        self.id = id
        self.courseName = courseName
        self.totalStep = totalStep
    }
}
