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
    typealias Dependencies = TimerService
    
    // MARK:- Protool conformance
    var willChange = PassthroughSubject<Void, Never>()
    
    class Input {
        
    }
    var input = Input()
    
    struct Output {
        
    }
    var output = Output()
    
    func setupBindings() { }
    
    // MARK:- Lifecycle
    init() {
        
    }

}
