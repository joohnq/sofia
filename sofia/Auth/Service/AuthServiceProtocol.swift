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
