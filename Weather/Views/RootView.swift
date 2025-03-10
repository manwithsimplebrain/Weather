//
//  RootView.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: RootViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isCheckingToken {
                loading.transition(.opacity)
            } else {
                if viewModel.tokenValid {
                    MainView().transition(.opacity)
                } else {
                    LoginView()
                        .transition(.opacity)
                        .environmentObject(viewModel.loginViewModel)
                }
            }
        }
        .animation(.default, value: viewModel.tokenValid)
        .task {
            await viewModel.checkToken()
        }
    }
    
    var loading: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Weather App")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    .bold()
                
                ProgressView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel())
}


