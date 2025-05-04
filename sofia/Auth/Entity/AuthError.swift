enum AuthError: Error {
    case EmailEmpty(Error)
    case EmailInvalid(Error)
    case PasswordEmty(Error)
    case PasswordTooWeak(Error)
    case Unknown(Error)
}
