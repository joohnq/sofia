import FirebaseAuth

@Observable
class AuthService: AuthServiceProtocol {
    private let auth: Auth
    var listener: NSObjectProtocol?

    init(auth: Auth) {
        self.auth = auth
        self.listener = nil
    }

    func signInWithEmailAndPassword(email: String, password: String) async
        -> Result<String, Error>
    {
        do {
            try await auth.signIn(withEmail: email, password: password)
            return .success("Sign In Sucessfully")
        } catch {
            print(error)
            return .failure(
                AuthError.Unknown(error)
            )
        }
    }

    func isLoggedIn() -> Bool {
        return auth.currentUser != nil
    }

    func addStateDidChangeListener(
        onAuth: @escaping (Auth) -> Void = { _ in },
        onUser: @escaping (User?) -> Void = { _ in }
    ) {
        let _ = auth.addStateDidChangeListener { auth, user in
            onAuth(auth)
            onUser(user)
        }
    }
}
