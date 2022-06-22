//
//  LoginView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

// https://blckbirds.com/post/login-page-in-swiftui-1/

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var authenticationDidFail = false

    var body: some View {
        VStack {
            WelcomeText()
            HeroImage()
            UsernameTextField(username: $username)
            PasswordTextField(password: $password)
            Button {
                print("Tapped")
            } label: {
                LoginText()
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct HeroImage: View {
    var body: some View {
        Image(systemName: "building.columns")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(48)
            .padding(.bottom, 72)
    }
}

struct UsernameTextField: View {
    @Binding var username: String

    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(.quaternary)
            .cornerRadius(8.0)
            .padding(.bottom, 20)
    }
}

struct PasswordTextField: View {
    @Binding var password: String

    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(.quaternary)
            .cornerRadius(8.0)
            .padding(.bottom, 20)
    }
}

struct LoginText: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(16)
    }
}
