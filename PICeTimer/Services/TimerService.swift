//
//  TimerService.swift
//  PICeTimer
//
//  Created by Adrian Ward on 13/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation
import Combine

final class TimerService {
    private var elapsedTime = TimeInterval()
    private var cancellables = [Cancellable]()
    
    let tick = PassthroughSubject<Date, Never>()
    
    
    func start() {
        if cancellables.isEmpty {
            let timerPublisher = Timer.publish(every: 1.0, tolerance: nil, on: .current, in: .common, options: nil)
            
            let timerSubjectStream = timerPublisher
                .subscribe(tick)
            
            let timerConnectStream = timerPublisher
                .connect()
            
            cancellables += [timerSubjectStream, timerConnectStream]
        }
    }
    
    func stop() {
        if cancellables.count > 2 { // threading protection - may be being ultra-cautious here!
            assertionFailure("Multi-thread activity detected - more Timer instances active than expected /(#file)")
        }
        for cancellable in cancellables {
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
}
