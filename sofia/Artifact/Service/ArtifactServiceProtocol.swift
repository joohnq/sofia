protocol ArtifactServiceProtocol {
    func getAll() -> Result<[Artifact], Error>
    func add(_ artifact: Artifact)
    func remove(_ artifact: Artifact)
    func update(_ artifact: Artifact)
    func toggleRead(_ artifact: Artifact)
    func toggleFlagged(_ artifact: Artifact)
    func markAsRead(_ artifact: Artifact)
}
