//
//  MainViewModel.swift
//  PICeTimer
//
//  Created by Adrian Ward on 01/08/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


protocol UnidirectionalDataType {
    // TODO:- Is there a way of hiding some of the implementation details here?
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    var cancellables: [Cancellable] { get }
    
    func setupBindings()
}

extension UnidirectionalDataType {
    func setupBindings() {
        fatalError("Must be implemented")
    }
}


final class MainViewModel: UnidirectionalDataType, ObservableObject {
    // MARK:- Properties
    private let timerService: TimerService
    private let apiService: ConcernAPIService
    private var elapsedTime: TimeInterval
    
    // MARK:- Protocol conformance
    /// ObservableObject
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    /// UnidirectionalDataType
    class Input {
        @Published var isTimerRunning = false
    }
    
    struct Output {
        var time: String = "00:00:00"
    }
    
    var input: Input
    var output: Output {
        willSet { objectWillChange.send() }
    }
    var cancellables = [Cancellable]()
    
    func setupBindings() {
        let timerToggleStream = input.$isTimerRunning
            .sink { state in
                if state { self.timerService.start() } else { self.timerService.stop() }
        }
        

        let elapsedTimeStream = timerService.tick
            .map { date in
                self.elapsedTime += 1
                return Utilities.formattedStringFrom(time: self.elapsedTime)
        }
        .assign(to: \.output.time, on: self)
        
        cancellables += [timerToggleStream, elapsedTimeStream]
    }
    
    
    // MARK:- Lifecycle
    init(timerService: TimerService, apiService: ConcernAPIService) {
        self.timerService = timerService
        self.apiService = apiService
        self.elapsedTime = 0.0
        
        input = Input()
        output = Output()
        setupBindings()
    }
    
}
