import Foundation
import Observation

@Observable
class InMemoryArtifactService: ArtifactServiceProtocol {
    private var artifacts: [Artifact] = Artifact.mockList

    func getAll() -> Result<[Artifact], Error> {
        return .success(artifacts)
    }

    func add(_ artifact: Artifact) {
        artifacts.append(artifact)
    }

    func remove(_ artifact: Artifact) {
        artifacts.removeAll(where: { a in a.id == artifact.id })
    }

    func update(_ artifact: Artifact) {
        if let index = artifacts.firstIndex(where: { a in a.id == artifact.id })
        {
            artifacts[index] = artifact
        }
    }

    func toggleRead(_ artifact: Artifact) {
        if let index = artifacts.firstIndex(where: { a in a.id == artifact.id })
        {
            artifacts[index].isRead.toggle()
        }
    }

    func toggleFlagged(_ artifact: Artifact) {
        if let index = artifacts.firstIndex(where: { a in a.id == artifact.id })
        {
            artifacts[index].isFlagged.toggle()
        }
    }

    func markAsRead(_ artifact: Artifact) {
        if let index = artifacts.firstIndex(where: { a in a.id == artifact.id })
        {
            artifacts[index].isRead = true
        }
    }
}
