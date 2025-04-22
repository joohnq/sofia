//
//  AuthState.swift
//  sofia
//
//  Created by Henrique on 10/03/25.
//
struct AuthState {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var status: UIState<String> = UIState.none
}
