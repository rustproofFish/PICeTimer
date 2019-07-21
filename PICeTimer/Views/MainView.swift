//
//  ContentView.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObjectBinding var viewModel: MainViewModel
    
    var body: some View {
        Text("Hello World")
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let viewModel = MainViewModel()
    
    static var previews: some View {
        MainView(viewModel: viewModel)
    }
}
#endif
