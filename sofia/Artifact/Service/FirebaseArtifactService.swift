import FirebaseFirestore
//
//  ArtifactStore.swift
//  sofia
//
//  Created by Henrique on 06/03/25.
//
import Foundation
import Observation

@Observable
class FirebaseArtifactService: ArtifactServiceProtocol {
    private var artifacts: [Artifact] = []

    let db: Firestore
    let collectionName = "artifacts"
    var collection: CollectionReference

    var listener: ListenerRegistration?

    init(db: Firestore) {
        self.db = db
        collection = db.collection(collectionName)
        enableLiveSync()
    }

    deinit {
        listener?.remove()
    }
    
    func getAll() -> Result<[Artifact], Error> {
        return .success(artifacts)
    }

    func enableLiveSync() {
        listener =
            collection
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {
                snapshot, error in
                if let snapshot = snapshot {
                    self.artifacts = snapshot.documents.compactMap { document in
                        do {
                            return try document.data(as: Artifact.self)
                        } catch {
                            print("Error decoding artifact: \(error)")
                            return nil
                        }
                    }
                }
            }
    }

    func markAsRead(_ artifact: Artifact) {
        var updatedArtifact = artifact
        updatedArtifact.isRead = true
        
        update(updatedArtifact)
    }

    func add(_ artifact: Artifact) {
        do {
            try collection.addDocument(from: artifact)
        } catch {
            print("Error deleting document: \(error)")
        }
    }

    func remove(_ artifact: Artifact) {
        guard let id = artifact.id else { return }

        collection.document(id).delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
            }
        }
    }

    func update(_ artifact: Artifact) {
        guard let id = artifact.id else { return }

        do {
            try collection.document(id).setData(from: artifact, merge: true)
        } catch {
            print("Error deleting document: \(error)")
        }
    }

    func toggleRead(_ artifact: Artifact) {
        var updatedArtifact = artifact
        updatedArtifact.isRead.toggle()
        update(updatedArtifact)
    }

    func toggleFlagged(_ artifact: Artifact) {
        var updatedArtifact = artifact
        updatedArtifact.isFlagged.toggle()
        update(updatedArtifact)
    }
}
