//
//  MainViewModel.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol UnidirectionalDataType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
    func setupBindings()
}



final class MainViewModel: BindableObject {
    // MARK:- Dependency injection
    typealias Dependencies = HasTimerService & HasConcernAPIService
    let dependencies: Dependencies
    
    // MARK:- Private properties
    private var cancellables = [Cancellable]() // store refs to ensure all cancelled on deinit
    
    // MARK:- Protool conformance
    var willChange = PassthroughSubject<Void, Never>()
    
    class Input { // Have to use internal class as @Published currently crashes inside structs
        var concerns: [Concern]
        @Published var isTimerRunning: Bool
        @Published var elapsedTime: TimeInterval { didSet { print("\(elapsedTime) secs") } }
        @Published var concernSearchString: String { didSet { print("case: \(concernSearchString)")}} // TODO: Rename as not clear
        @Published var selectedConcern: Concern? { didSet { print("Selected: \(String(describing: selectedConcern))") } }
        
        init(concerns: [Concern]) {
            self.concerns = concerns
            self.isTimerRunning = false
            self.elapsedTime = 0.0
            self.concernSearchString = "" // clumsy! better name needed
            self.selectedConcern = nil
        }
    }
    var input: Input!
    
    struct Output {
        var concerns = [Concern]()
        var isTimerRunning = false { didSet { print("Output \(isTimerRunning)") } }
        var isTimerButtonDisabled = false
        var isConcernSearchFieldDisabled = false
        var elapsedTime = ""
    }
    var output = Output() {
        willSet { willChange.send() }
    }
    
    func setupBindings() {
        // Bind services
        let elapsedTimeCancellable = dependencies.timerService.elapsedTimeSubject
            .assign(to: \.input.elapsedTime, on: self)
        
        // Bind input to output properites
        output.concerns = input.concerns
        
        let elapsedTimeUIUpdateCancellable = input.$elapsedTime
            .map { value in Utilities.formattedStringFrom(time: value) }
            .assign(to: \.output.elapsedTime, on: self)
        
        let timerButtonUIUpdateCancellable = input.$isTimerRunning
            .assign(to: \.output.isTimerRunning, on: self)
        
        let timerButtonDisabledCancellable = input.$concernSearchString
            .map { $0.isEmpty }
            .assign(to: \.output.isTimerButtonDisabled, on: self)
        
        let timerServiceToggleCancellable = input.$isTimerRunning
            .sink { state in
                switch state {
                case true:
                    #warning("Create a new case or utilise the one selectedd by the user")
                    self.output.isConcernSearchFieldDisabled = true
                    self.dependencies.timerService.start()
                case false:
                    self.output.isConcernSearchFieldDisabled = false
                    self.dependencies.timerService.stop()
                    // TODO - persist the concern (update existing or create a new one)
                }

        }
        
        cancellables += [elapsedTimeCancellable,
                         elapsedTimeUIUpdateCancellable,
                         timerButtonUIUpdateCancellable,
                         timerButtonDisabledCancellable,
                         timerServiceToggleCancellable]
    }
    
    // MARK:- Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        input = Input(concerns: dependencies.apiService.concerns)
        output = Output(concerns: input.concerns)
        
        setupBindings()
    }

}
