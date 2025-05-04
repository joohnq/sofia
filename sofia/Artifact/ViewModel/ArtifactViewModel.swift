import Foundation

class ArtifactViewModel: ObservableObject {
    @Published var state: ArtifactState = ArtifactState()

    private let service: ArtifactServiceProtocol

    init(service: ArtifactServiceProtocol) {
        self.service = service
        getArtifacts()
    }

    func getArtifacts() {
        state.artifacts = UIState.loading
        performOperation(
            task: {
                print("Fetching")
                return self.service.getAll()
            },
            success: { value in
                print(value)
                self.state.artifacts = UIState.success(value: value)
                return
            },
            failure: { error in
                print("Erro \(error)")
                self.state.artifacts = UIState.error(
                    error: error.localizedDescription
                )
                return
            }
        )
    }

    func add(_ artifact: Artifact) {
        self.service.add(artifact)
    }
    func remove(_ artifact: Artifact) {
        self.service.remove(artifact)
    }
    func update(_ artifact: Artifact) {
        self.service.update(artifact)
    }
    func toggleRead(_ artifact: Artifact) {
        self.service.toggleRead(artifact)
    }
    func toggleFlagged(_ artifact: Artifact) {
        self.service.toggleFlagged(artifact)
    }
    func markAsRead(_ artifact: Artifact) {
        self.service.markAsRead(artifact)
    }
}
