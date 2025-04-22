//
//  AuthService.swift
//  sofia
//
//  Created by Henrique on 10/03/25.
//
import FirebaseAuth

protocol AuthServiceProtocol {
    var listener: NSObjectProtocol? { get }

    func signInWithEmailAndPassword(email: String, password: String)
        async -> Result<String, Error>

    func isLoggedIn() -> Bool

    func addStateDidChangeListener(
        onAuth: @escaping (Auth) -> Void,
        onUser: @escaping (User?) -> Void
    )
}
