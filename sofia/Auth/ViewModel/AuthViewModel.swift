import FirebaseAuth
import Foundation

class AuthViewModel: ObservableObject {
    @Published var state: AuthState = AuthState()
    @Published var user: User?

    private let service: AuthServiceProtocol

    var isLoggedIn: Bool {
        user != nil
    }

    init(service: AuthServiceProtocol) {
        self.service = service
        service.addStateDidChangeListener(
            onAuth: { _ in },
            onUser: { user in
                self.user = user
            }
        )
    }

    func signInWithEmailAndPassword() {
        state.status = UIState.loading
        performAsyncOperation(
            asyncTask: {
                await self.service.signInWithEmailAndPassword(
                    email: self.state.email, password: self.state.password
                )
            },
            success: { value in
                self.state.status = UIState.success(value: value)
            },
            failure: { error in
                self.state.status = UIState.error(
                    error: error.localizedDescription)
            }
        )
    }

    func clearSignInFields() {
        state.email = ""
        state.password = ""
    }
}
