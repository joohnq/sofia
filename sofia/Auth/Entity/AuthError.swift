//
//  AuthError.swift
//  sofia
//
//  Created by Henrique on 11/03/25.
//
enum AuthError: Error {
    case EmailEmpty(Error)
    case EmailInvalid(Error)
    case PasswordEmty(Error)
    case PasswordTooWeak(Error)
    case Unknown(Error)
}
