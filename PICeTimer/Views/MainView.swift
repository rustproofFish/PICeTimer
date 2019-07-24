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
                    
                    List(viewModel.output.concerns) { concern in
                        HStack {
                            Text(Utilities.formattedStringFrom(date: concern.date))
                            Text(concern.reference)
                                .padding([.leading], 16)
                            Text(concern.parties)
                            Spacer()
                            Text(Utilities.formattedStringFrom(time: concern.time))
                        }
                        .font(.subheadline)
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
                .navigationBarTitle("PICeTimer")
                
            }
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
