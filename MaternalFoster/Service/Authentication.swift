//
//  Authentication.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/2/26.
//

import Foundation
import SwiftUI
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
internal import Combine

final class Authentication: ObservableObject {
    @Published var user: User?
    @Published var isSigningIn = false
    @Published var authError: String?

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    @MainActor
    func signInWithGoogle() async {
        authError = nil
        isSigningIn = true

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            authError = "Missing Firebase client ID."
            isSigningIn = false
            return
        }

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = scene.windows.first?.rootViewController else {
            authError = "Could not access the root view controller."
            isSigningIn = false
            return
        }

        do {
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

            guard let idToken = result.user.idToken?.tokenString else {
                authError = "Could not get Google ID token."
                isSigningIn = false
                return
            }

            let accessToken = result.user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: accessToken
            )

            let authResult = try await Auth.auth().signIn(with: credential)
            self.user = authResult.user
        } catch {
            self.authError = error.localizedDescription
        }

        isSigningIn = false
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            self.user = nil
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
    }
}
