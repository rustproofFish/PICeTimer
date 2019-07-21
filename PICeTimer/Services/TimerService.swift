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
    private var timer: Cancellable?
    private var elapsedTime = TimeInterval()
    private var cancellables = [Cancellable]()
    
    let elapsedTimeSubject = PassthroughSubject<TimeInterval, Never>()
    
    func start() {
        print("Start called")
        if timer == nil {
            let timerPublisher = Timer.publish(every: 1.0, tolerance: nil, on: .current, in: .common, options: nil)
            
            let elapsedTimePublisher = timerPublisher
                .scan(0, { (value1, value2) in value1 + 1})
                .subscribe(elapsedTimeSubject) // emitt elapsed seconds
            
            timer = timerPublisher
                .connect()
            
            cancellables += [timer!, elapsedTimePublisher]
        
        }
    }
    
    func stop() {
        print("Stop called")
        if cancellables.count > 2 {
            assertionFailure("Multi-thread activity detected - more timers active than expected /(#file)")
        }
        timer?.cancel()
        #warning("If the case is new, reset the timer otherwise increment")
        timer = nil
        cancellables.removeAll()
    }
}
