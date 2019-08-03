//
//  ContentView.swift
//  PICeTimer
//
//  Created by Adrian Ward on 21/07/2019.
//  Copyright © 2019 Adrian Ward. All rights reserved.
//

import SwiftUI


struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                
                VStack(alignment: .leading) {
                    Text("CURRENT")
                        .font(.callout)
//                    Text("00:00:00")
                    Text(viewModel.output.time)
                        .font(.system(size: 64, weight: .heavy, design: .default))
                    
                    Text("TODAY")
                        .font(.caption)
                    Text("00:00:00")
                        .font(.largeTitle)
                    
                    Text("MONTH")
                        .font(.caption)
                    Text("00:00:00")
                        .font(.largeTitle)
                }
                .padding([.bottom], 64)
                
                HStack {
                    TextField("Case reference or parties", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: { self.viewModel.input.isTimerRunning.toggle() }) {
                        Image(systemName:"play")
                            .font(.largeTitle)
                    }
                }
                
                List {
                    Text("Item")
                }
                .frame(height: 200, alignment: .bottom)
                .hidden()
            }
            .padding()
                
            .navigationBarItems(leading:
                Image(systemName: "person.fill"),
                                trailing:
                Image(systemName: "tray.and.arrow.up")
            )
                .font(.title)
        }
        
    }
}




#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let timerService = TimerService()
    static let apiService = ConcernAPIService()
    static let viewModel = MainViewModel(timerService: timerService, apiService: apiService)
    
    static var previews: some View {
        MainView(viewModel: viewModel)
    }
}
#endif
