//
//  TimerButtonView.swift
//  PICeTimer
//
//  Created by Adrian Ward on 22/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import SwiftUI

struct TimerButtonView: View {
    private enum ButtonState {
        case start, stop, disabled
        
        private var colour: Color {
            switch self {
            case .start: return .green
            case .stop: return .red
            case .disabled: return .gray
            }
        }
        
        private var image: Image {
            switch self {
            case .start, .disabled: return Image(systemName: "play")
            case .stop: return Image(systemName: "stop")
            }
        }
        
        var view: some View {
            return image.foregroundColor(colour)
        }
        
        init?(isTimerRunning: Bool, isButtonDisabled: Bool) {
            if isButtonDisabled {
                self = .disabled
            } else {
                self = isTimerRunning ? .stop : .start
            }
            
        }
    
    }
    
    @State var flags: (isTinerRunning: Bool, isButtonDisabled: Bool)
    
    var body: some View {
        Text("Hello")
    }
}

#if DEBUG
struct TimerButtonView_Previews: PreviewProvider {
    static let flags = (true, false)
    
    static var previews: some View {
        TimerButtonView(flags: flags)
    }
}
#endif
