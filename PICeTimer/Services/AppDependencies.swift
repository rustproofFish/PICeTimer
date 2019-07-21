//
//  AppDependencies.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation

protocol HasTimerService {
    var timerService: TimerService { get }
}

struct AppDependencies: HasTimerService {
    var timerService = TimerService()
}
