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
                    Text("Case details")
                        .fontWeight(.light)
                        .padding(.leading, 16)
                    Spacer()
                    Text("00:00:00")
                    Button(action: { }) {
                        Image(systemName: "play")
                    }
                        .padding([.leading, .trailing], 16)
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
