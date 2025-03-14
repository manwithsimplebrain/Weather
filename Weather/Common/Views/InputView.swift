//
//  InputView.swift
//  Weather
//
//  Created by Dat Doan on 11/3/25.
//

import SwiftUI

struct InputView: View {
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    
    @State private var isTextVisible = false
    
    init(placeholder: String, text: Binding<String>, isSecure: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        VStack {
            HStack {
                if isSecure && !isTextVisible {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
                
                if isSecure {
                    Button(action: {
                        isTextVisible.toggle()
                    }) {
                        Image(systemName: isTextVisible ? "eye.slash" : "eye")
                    }
                }
            }
            .padding()
            .padding(.horizontal, 4)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
        }
    }
}


#Preview {
    VStack {
        InputView(
            placeholder: "Email",
            text: .constant("datdoan@gmail.com")
        )
        
        InputView(
            placeholder: "Password",
            text: .constant("123456"),
            isSecure: true
        )
        .tint(.primary)
    }
    .padding()
}
