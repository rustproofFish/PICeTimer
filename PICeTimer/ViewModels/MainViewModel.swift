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
    
    // MARK:- Protool conformance
    var willChange = PassthroughSubject<Void, Never>()
    
    // MARK:- Private properties
    private var cancellables = [Cancellable]() // store refs to ensure all cancelled on deinit
    
    // MARK:- Have to use internal class as @Published crashes inside structs
    class Input {
        var concerns: [Concern]
        @Published var isTimerRunning: Bool {
            didSet { print("isTimerRunning \(isTimerRunning)")}
        }
        
        init(concerns: [Concern]) {
            self.concerns = concerns
            self.isTimerRunning = false
        }
    }
    var input: Input!
    
    struct Output {
        var concerns = [Concern]()
        var isTimerRunning = false { didSet { print("Output \(isTimerRunning)") } }
        var isButtonDisabled = false
    }
    var output = Output() {
        willSet { willChange.send() }
    }
    
    func setupBindings() {
        output.concerns = input.concerns
        
        let timerCancellable = input.$isTimerRunning
            .assign(to: \.output.isTimerRunning, on: self)
        
        cancellables.append(timerCancellable)
    }
    
    // MARK:- Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        input = Input(concerns: dependencies.apiService.concerns)
        output = Output(concerns: input.concerns)
        
        setupBindings()
    }

}
