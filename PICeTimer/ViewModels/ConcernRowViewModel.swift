//
//  ConcernRowViewModel.swift
//  PICeTimer
//
//  Created by Adrian Ward on 01/08/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import Foundation
import SwiftUI

class ConcernRowViewModel {
    private let concern: Concern
    
    var date: String {
        return Utilities.formattedStringFrom(date: concern.date)
    }
    
    var reference: String {
        return concern.reference
    }
    
    var parties: String {
        return concern.parties
    }
    
    var time: String {
        return Utilities.formattedStringFrom(time: concern.time)
    }
    
    
    init(concern: Concern) {
        self.concern = concern
    }
}
