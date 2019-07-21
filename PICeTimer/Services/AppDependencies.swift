//
//  AppDependencies.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation

/// For dependency injection by protocol composition
struct AppDependencies: HasConcernAPIService, HasTimerService {
    var apiService = ConcernAPIService()
    var timerService = TimerService()
}

protocol HasTimerService {
    var timerService: TimerService { get }
}

protocol HasConcernAPIService {
    var apiService: ConcernAPIService { get }
}
