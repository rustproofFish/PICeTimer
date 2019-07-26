//
//  Concern.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Concern: Identifiable {
    // MARK:- Protocol conformance
    let id: String
    
    // MARK:- Properties
    var reference: String
    var parties: String
    var date: Date
    var time: TimeInterval
    
    init(reference: String, parties: String, dateAssessd: Date, time: TimeInterval) {
        self.id = UUID().uuidString
        self.reference = reference
        self.parties = parties
        self.date = dateAssessd
        self.time = time
    }
}
