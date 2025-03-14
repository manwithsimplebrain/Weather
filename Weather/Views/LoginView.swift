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
            termAndCondition
        }
        .padding()
    }
    
    var title: some View {
        VStack {
            Text("Create an account")
                .font(.title)
            HStack {
                Text("Already have an account?")
                    .font(.footnote)
                Button {
                    
                } label: {
                    Text("Login")
                }
            }
        }
    }
    
    var signIn: some View {
        Button("Sign In") {
            viewModel.login(username: username, password: password)
        }
        .buttonStyle(AnimationButtonStyle())
        .padding(.top, 12)
    }
    
    var input: some View {
        VStack(spacing: 20) {
            InputView(placeholder: "Username", text: $username)
            InputView(placeholder: "Password", text: $password, isSecure: true)
        }
        .tint(.primary)
        .textInputAutocapitalization(.never)
        .padding(.top, 20)
    }
    
    var divider: some View {
        HStack(spacing: 15) {
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(height: 3)

            Text("or sign up with").font(.headline).foregroundStyle(Color(.systemGray2))
                .lineLimit(1)
                .layoutPriority(2)
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(height: 3)
        }
        .padding(.vertical, 30)
    }
    
    var oauthProviders: some View {
        HStack(spacing: 40) {
            ImageButton(name: "ic_google") { loginByAuthProvider(.google) }
            ImageButton(name: "ic_zalo") { loginByAuthProvider(.zalo) }
            ImageButton(name: "ic_facebook") { loginByAuthProvider(.facebook) }
        }
    }
    
    @ViewBuilder
    var termAndCondition: some View {
        Text("By click create account you agree to recognize")
            .font(.footnote)
        Text("Terms of use")
            .font(.footnote)
            .foregroundColor(.blue)
            .underline()
        + Text(" and ")
            .font(.footnote)
        + Text("Privacy Policy")
            .font(.footnote)
            .foregroundColor(.blue)
            .underline()
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

struct AnimationButtonStyle: ButtonStyle {
    var background: Color = .blue
    var foreground: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(background.opacity(configuration.isPressed ? 0.8 : 1))
            .clipShape(Capsule())
            .foregroundStyle(foreground)
            .fontWeight(.bold)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
