//
//  ConcernAPIService.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation

final class ConcernAPIService {
    var concerns = [Concern]()
    
    init() {
        createDummyData()
    }
    
    private func createDummyData() {
        for i in 1...20 {
            let reference = String(UUID().uuidString.prefix(8))
            let parties = "Comp\(i) v Resp\(i)"
            let date = Date(timeIntervalSinceReferenceDate: Double.random(in: 300000...1200000))
            let time = TimeInterval(exactly: Double.random(in: 0...98000))!
            let concern = Concern(reference: reference, parties: parties, dateAssessd: date, time: time)
            concerns.append(concern)
        }
    }
}
