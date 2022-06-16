//
//  String+Extension.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/08.
//

import Foundation
import SwiftUI

extension String {
    func toColor(alpha: Double) -> Color {
        var hexString = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return Color.black
        }
        var rgbInt: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbInt)
        return Color.init(red: CGFloat((rgbInt & 0xFF0000) >> 16) / 255.0,
                          green: CGFloat((rgbInt & 0x00FF00) >> 8) / 255.0,
                          blue: CGFloat(rgbInt & 0x0000FF) / 255.0,
                          opacity: alpha)
    }
}
