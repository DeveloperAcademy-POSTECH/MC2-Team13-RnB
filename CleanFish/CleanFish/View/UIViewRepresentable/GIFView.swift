//
//  GIFView.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/13.
//

import Foundation
import WebKit
import SwiftUI

struct GIFView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func makeUIView(context: Context) -> UIViewType {
        let wkWebView = WKWebView()
        
        guard let url = Bundle.main.url(forResource: self.fileName, withExtension: "gif") else {
            return wkWebView
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return wkWebView
        }
        
        wkWebView.load(data,
                       mimeType: "image/gif",
                       characterEncodingName: "UTF-8",
                       baseURL: url.deletingLastPathComponent())
        wkWebView.scrollView.isScrollEnabled = false
        wkWebView.scrollView.isUserInteractionEnabled = false
        
        return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
