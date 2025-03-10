//
//  LoginView.swift
//  Weather
//
//  Created by Dat Doan on 6/3/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack {
            title
            input
            signIn
            divider
            oauthProviders
            
            Spacer()
        }
    }
    
    var title: some View {
        Text("Login")
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
    
    var signIn: some View {
        Button("Sign In") {
            viewModel.login(username: username, password: password)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
        .background(Color.blue)
        .clipShape(Capsule())
        .foregroundStyle(.white)
        .fontWeight(.heavy)
    }
    
    var input: some View {
        VStack {
            TextField("Username", text: $username)
            TextField("Password", text: $password)
        }
        .textFieldStyle(.roundedBorder)
        .textInputAutocapitalization(.never)
        .padding()
    }
    
    var divider: some View {
        HStack(spacing: 15) {
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(height: 3)

            Text("OR").font(.headline).foregroundStyle(Color(.systemGray2))
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(height: 3)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 30)
    }
    
    var oauthProviders: some View {
        HStack(spacing: 40) {
            ImageButton(name: "ic_google") { loginByAuthProvider(.google) }
            ImageButton(name: "ic_zalo") { loginByAuthProvider(.zalo) }
            ImageButton(name: "ic_facebook") { loginByAuthProvider(.facebook) }
        }
        
    }
}

extension LoginView {
    private func loginByAuthProvider(_ provider: AuthProvider) {
        viewModel.loginByAuthProvider(provider)
    }
}

typealias VoidCallback = () -> Void
struct ImageButton: View {
    let name: String
    let onTap: VoidCallback?
    
    init(name: String, onTap: VoidCallback? = nil) {
        self.name = name
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: onTap ?? {}) {
            Image(name)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
