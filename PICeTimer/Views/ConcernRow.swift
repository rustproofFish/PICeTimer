//
//  ConcernRow.swift
//  PICeTimer
//
//  Created by Adrian Ward on 01/08/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import SwiftUI

struct ConcernRow: View {
    private let concern: Concern
    var viewModel: ConcernRowViewModel {
        return ConcernRowViewModel(concern: concern)
    }
    
    // Required because structs won't synthesise inits for private properties
    init(concern: Concern) {
        self.concern = concern
    }
    
    var body: some View {
        HStack {
            Text(viewModel.date)
            Text(viewModel.reference)
            Text(viewModel.parties)
            Text(viewModel.time)
                .fontWeight(.heavy)
      }
    }
}

#if DEBUG
struct ConcernRow_Previews: PreviewProvider {
    static let concern = Concern(reference: "CON000765", parties: "Smith v Parker", dateAssessd: Date(), time: Double.random(in: 0..<36000))
    
    static var previews: some View {
        ConcernRow(concern: concern )
    }
}
#endif
