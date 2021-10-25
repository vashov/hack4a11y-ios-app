//
//  DashboardView.swift
//  Objectiver
//
//  Created by Борис Вашов on 15.10.2021.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UIToolbar.appearance().tintColor = UIColor.red
    }
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.isLoading)) {
            NavigationView {
                ZStack {
                    LogoBackgroundView()
                    
                    VStack {
                        ScrollView {
                            VStack {
                                HStack {
        //                            Image(systemName: "crown")
                                    Text("level")
                                    Text(String(viewModel.level))
                                    ProgressBar(value: $viewModel.levelProgress)
                                    Image(systemName: "rosette")
                                    Text(String(viewModel.completedTaskCount))
                                }
                                .padding()
                                .padding(.top)
                                
                                if viewModel.currentTasks.count == 0 {
                                    Text("You have no active tasks")
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.backgroundPrimary)
                                                .shadow(radius: 5)
                                                .frame(width: UIScreen.main.bounds.width - 30)
                                        )
                                        .padding()
                                } else {
                                    ForEach(viewModel.currentTasks) { taskModel in
                                        NavigationLink(
                                            destination: QueryView(queryId: taskModel.queryId),
                                            label: {
                                                TaskCardView(
                                                    title: taskModel.title,
                                                    date: taskModel.date,
                                                    onPress: { })
                                                    })
                                    }
                                }
                                Spacer()
                            }
                            .onAppear(perform: viewModel.initialize)
                            
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: viewModel.reload) {
                                Image(systemName: "goforward")
                            }
                            
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape")
                            }
                            .navigationTitle("Settings")
                        }
                    }
                    
                }
                
            }
        }
        .accentColor(.black)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
