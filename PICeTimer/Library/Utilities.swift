//
//  Utilities.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation

struct Utilities {
    static func formattedStringFrom(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        
        return formatter.string(from: date)
    }
    
    static func formattedStringFrom(time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: time)! // shouldn't fail so force unweap acceptable
    }
}
