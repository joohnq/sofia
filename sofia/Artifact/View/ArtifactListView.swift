import FirebaseAuth
import GoogleGenerativeAI
import OpenGraphReader
import SwiftUI
import WebViewKit

struct ArtifactListView: View {
    @Environment(MetadataService.self) var metadataService
    @Environment(SummarizeService.self) var summarizeService
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var artifactViewModel: ArtifactViewModel

    @State var showAddArtifact: Bool = false
    @State var showAuthDialog: Bool = false
}

extension ArtifactListView {
    var body: some View {
        return NavigationStack {
            artifactViewModel.state.artifacts.handle(
                onLoading: {
                    AnyView(ArtifactListLoadingView())
                },
                onSuccess: { artifacts in
                    AnyView(
                        ArtifactListSuccessView(
                            artifacts: artifacts,
                            showAddArtifact: $showAddArtifact,
                            showAuthDialog: $showAuthDialog
                        )
                        .environmentObject(artifactViewModel)
                        .environmentObject(authViewModel)
                    )
                },
                onError: { error in
                    AnyView(ArtifactListErrorView(message: error))
                }
            )
        }
    }
}

#Preview {
    @Previewable var artifactViewModel = ArtifactViewModel(
        service: InMemoryArtifactService()
    )

    @Previewable var summarizeService = SummarizeService(
        model: GenerativeModel(
            name: "gemini-2.0-flash-exp",
            apiKey: APIKey.default
        )
    )
    @Previewable var metadataService = MetadataService(
        reader: OpenGraphReader())
    @Previewable @State var authViewModel = AuthViewModel(
        service: AuthService(auth: Auth.auth()))

    NavigationStack {
        ArtifactListView()
            .environment(metadataService)
            .environment(summarizeService)
            .environmentObject(authViewModel)
            .environmentObject(artifactViewModel)
    }
}
