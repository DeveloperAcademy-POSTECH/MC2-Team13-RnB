//
//  Step.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/11.
//

import Foundation

struct RequestStepDTO: Codable {
    var courseID: UUID // 코스의 ID
    var currentStep: Int // 현재 단계
}

struct Step: Codable {
    var courseID: UUID // 코스의 ID
    var currentStep: Int // 현재 단계
    var totalStep: Int // 총 단계
    var title: String // 현재 단계의 제목
    var content: String // 현재 단계의 내용
    
    init(courseID: UUID = UUID(), currentStep: Int = 0, totalStep: Int = 0, title: String = "", content: String = "") {
        self.courseID = courseID
        self.currentStep = currentStep
        self.totalStep = totalStep
        self.title = title
        self.content = content
    }
}
