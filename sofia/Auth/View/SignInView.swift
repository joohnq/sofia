import FirebaseAuth
import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
}

extension SignInView {
    var body: some View {
        VStack {
            Text("Welcome to Sofia")
                .font(.largeTitle)
                .fontWeight(.bold)

            HStack {
                Image(systemName: "at")
                TextField("Email", text: $authViewModel.state.email)
                    .textInputAutocapitalization(.never)
                    .textContentType(.emailAddress)
            }.padding(.vertical, 6).padding(.bottom, 4)
                .background(Divider(), alignment: .bottom)
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $authViewModel.state.password)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
            }
            .padding(.vertical, 6)
            .padding(.bottom, 4)
            Button(action: {
                authViewModel.signInWithEmailAndPassword()
            }
            ) {
                if authViewModel.state.status == UIState.loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else {
                    Text("Sign In")
                }
            }
            .frame(width: .infinity)
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
        .disabled(authViewModel.state.status == UIState.loading)
        .alert(isPresented: .constant(authViewModel.state.status.isError)) {
            if case .error(let errorMessage) = authViewModel.state.status {
                return Alert(
                    title: Text("Erro de Login"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            return Alert(title: Text("Erro desconhecido"))
        }
        .onChange(of: authViewModel.state.status) {
            if authViewModel.state.status.isError {
                authViewModel.clearSignInFields()
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = AuthViewModel(
        service: AuthService(auth: Auth.auth())
    )
    SignInView()
        .environmentObject(viewModel)
}
