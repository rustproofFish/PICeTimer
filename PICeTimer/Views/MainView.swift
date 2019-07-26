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
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    TextField("Concern details", text: $viewModel.input.concernSearchString)
                        .disabled(viewModel.output.isConcernSearchFieldDisabled)
                        .padding(.leading, 16)
                    
                    Text(viewModel.output.elapsedTime)
                    Button(action: {
                        self.viewModel.input.isTimerRunning.toggle() })
                    {
                        StatefulButtonUI(isTimerRunning: viewModel.output.isTimerRunning, isButtonDisabled: viewModel.output.isTimerButtonDisabled)?.view
                    }
                    .disabled(viewModel.output.isTimerButtonDisabled)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 16))
                }
                .font(.largeTitle)
                    .padding(.vertical, 32)
                
                
                
                List {
                    ForEach(0..<viewModel.output.concerns.count) { index in
                        PresentationLink(destination: ConcernDetailView(concern: self.$viewModel.output.concerns[index])) {
                            
                            HStack {
                                Text(Utilities.formattedStringFrom(date: self.viewModel.output.concerns[index].date))
                                Text(self.viewModel.output.concerns[index].reference)
                                    .padding([.leading], 16)
                                Text(self.viewModel.output.concerns[index].parties)
                                Spacer()
                                Text(Utilities.formattedStringFrom(time: self.viewModel.output.concerns[index].time))
                            }
                            .font(.subheadline)
                            
                        }
                    }
                }
                
                HStack {
                    Text("Total time for June")
                    Spacer()
                    Text("00:00:00")
                        .fontWeight(.bold)
                }
                .padding()
                    .font(.callout)
            }
        }
        .navigationBarTitle("PICeTimer")
        
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let viewModel = MainViewModel(dependencies: AppDependencies())
    
    static var previews: some View {
        MainView(viewModel: viewModel)
    }
}
#endif

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
