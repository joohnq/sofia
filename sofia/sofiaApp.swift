//
//  sofiaApp.swift
//  sofia
//
//  Created by Henrique on 05/03/25.
//
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleGenerativeAI
import OpenGraphReader
import SwiftUI

@main
struct SofiaApp: App {
    private let model = GenerativeModel(
        name: "gemini-2.0-flash-exp",
        apiKey: APIKey.default
    )
    private let metadataService: MetadataService
    private let summarizerService: SummarizeService

    @StateObject private var authViewModel: AuthViewModel
    @StateObject private var artifactViewModel: ArtifactViewModel

    init() {
        FirebaseApp.configure()
        let reader = OpenGraphReader()
        let firestore = Firestore.firestore()
        let auth = Auth.auth()
        let authService = AuthService(auth: auth)
        let artifactService = FirebaseArtifactService(db: firestore)
        let metadataService = MetadataService(reader: reader)
        let summarizerService = SummarizeService(model: model)
        let authViewModel = AuthViewModel(service: authService)
        let artifactViewModel = ArtifactViewModel(service: artifactService)

        self.metadataService = metadataService
        self.summarizerService = summarizerService
        
        _authViewModel = StateObject(wrappedValue: authViewModel)
        _artifactViewModel = StateObject(wrappedValue: artifactViewModel)
    }

    var body: some Scene {
        WindowGroup {
            ArtifactListView()
                .environment(metadataService)
                .environment(summarizerService)
                .environmentObject(authViewModel)
                .environmentObject(artifactViewModel)
        }
    }
}
