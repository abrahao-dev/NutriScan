//
//  AuthenticationManager.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/24/25.
//

import Foundation
import FirebaseAuth

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init () {}
    
    func getLoggedInUser() -> UserInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return UserInfo(user: user)
    }
    
    func createUserAccount(withEmail email: String, password: String, name: String) async throws -> UserInfo {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let changeRequest = authResult.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        return UserInfo(user: authResult.user)
    }
    
    func loginUser(withEmail email: String, password: String) async throws -> UserInfo {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserInfo(user: authResult.user)
    }
}
