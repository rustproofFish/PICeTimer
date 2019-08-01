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
    @State private var isPresented = false
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("CURRENT")
                        Text(viewModel.output.elapsedTime)
                            .font(Font.system(size: 80, design: .rounded))
                    }
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("TODAY")
                            .font(.caption)
                        Text("00:00:00")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text("MONTH")
                            .font(.caption)
                        Text("00:00:00")
                            .font(.largeTitle)
                    }
                        .foregroundColor(.gray)
                    
                }
                
                
                HStack {
                    
                    TextField("Case reference / parties", text: $search)
                        .textFieldStyle(.roundedBorder)
                        .font(.title)
                    
                    Button(action: {
                        self.viewModel.input.isTimerRunning.toggle() })
                    {
                        StatefulButtonUI(isTimerRunning: viewModel.output.isTimerRunning, isButtonDisabled: viewModel.output.isTimerButtonDisabled)?.view
                    }
                    .font(.largeTitle)
                        .disabled(viewModel.output.isTimerButtonDisabled)
                    
                }
                .padding(32)
                
                
                List {
                    ForEach(0..<viewModel.output.concerns.count) { index in
                        //                        PresentationLink(destination: ConcernDetailView(concern: self.$viewModel.output.concerns[index])) {
                        
                        HStack {
                            Text(Utilities.formattedStringFrom(date: self.viewModel.output.concerns[index].date))
                            Text(self.viewModel.output.concerns[index].reference)
                                .padding([.leading], 16)
                            Text(self.viewModel.output.concerns[index].parties)
                            Spacer()
                            Text(Utilities.formattedStringFrom(time: self.viewModel.output.concerns[index].time))
                        }
                            // add a touch target to enable row selection?
                            .font(.subheadline)
                        
                        //                        }
                    }
                }
                    .hidden()
                .sheet(isPresented: $isPresented, content: { Text("I'm presented") })
                
            }
        }
        
        
    }
}


extension MainView {
    private enum StatefulButtonUI {
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
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let viewModel = MainViewModel(dependencies: AppDependencies())
    
    static var previews: some View {
        NavigationView {
            MainView(viewModel: viewModel)
        }
    }
}
#endif
