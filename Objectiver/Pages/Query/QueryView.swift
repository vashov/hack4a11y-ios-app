//
//  QueryDetailsView.swift
//  Objectiver
//
//  Created by Борис Вашов on 23.10.2021.
//

import SwiftUI

struct QueryView: View {
    
    @ObservedObject var viewModel: QueryViewModel
    
    init(queryId: Int) {
        viewModel = QueryViewModel(queryId: queryId)
    }
    
    init(latitude: Double, longitude: Double) {
        
        viewModel = QueryViewModel(
            longitude: longitude,
            latitude: latitude)
    }
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack {
                HStack {
                    Text("Latitude: \(viewModel.latitude)")
                    Spacer()
                }
                
                HStack {
                    Text("Longitude: \(viewModel.longitude)")
                    Spacer()
                }
                
                HStack {
                    Text("Description:")
                    Spacer()
                }
                .padding(.top)
                
                TextEditor(text: $viewModel.description)
                    .shadow(radius: 5)
                    .disabled(!viewModel.isModeCreate)
                Spacer()
                
                if viewModel.isModeCreate {
                    Button(action:  { viewModel.createQuery(completion: {_ in }) },
                           label: {
                        Text("Create")
                            .foregroundColor(.foregroundSecond)
                            .bold()
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.backgroundSecond)
                            .clipShape(Capsule())

                    })
                    .padding(.top, 22)
                    .disabled(!viewModel.isValidForm)
                }
                
                if viewModel.canFinish {
                    Button(action:  { viewModel.finishQuery(completion: {
                        
                    }) },
                           label: {
                        Text("Finish")
                            .foregroundColor(.foregroundSecond)
                            .bold()
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.backgroundSecond)
                            .clipShape(Capsule())

                    })
                    .padding(.top, 22)
                    .disabled(!viewModel.isValidForm)
                }
                
                if viewModel.canStartExecute {
                    Button(action:  { viewModel.takeQuery(completion: {
                        
                    }) },
                           label: {
                        Text("Start")
                            .foregroundColor(.foregroundSecond)
                            .bold()
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.backgroundSecond)
                            .clipShape(Capsule())

                    })
                    .padding(.top, 22)
                    .disabled(!viewModel.isValidForm)
                }
                
                
            }
        }
        
        .padding()
        .navigationTitle("Task Details")
        .onAppear(perform: viewModel.initilize)
        
    }
}

struct QueryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        QueryView(queryId: 2)
    }
}
