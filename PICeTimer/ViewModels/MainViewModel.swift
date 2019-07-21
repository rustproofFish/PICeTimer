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
    
    class Input {
        var concerns: [Concern]
        
        init(concerns: [Concern]) {
            self.concerns = concerns
        }
    }
    var input: Input!
    
    struct Output {
        var concerns = [Concern]()
    }
    var output: Output!
    
    func setupBindings() {
        output.concerns = input.concerns
    }
    
    // MARK:- Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        input = Input(concerns: dependencies.apiService.concerns)
        output = Output(concerns: input.concerns)
    }

}
