import OpenGraphReader
import GoogleGenerativeAI
import SwiftUI
import WebViewKit

struct ArtifactDetailView: View {
    @Environment(FirebaseArtifactService.self) var store
    @Environment(SummarizeService.self) var summarizeService
    @State var artifact: Artifact
    @State var showNoteEditor: Bool = false
    @State var notes: String = ""

    func markArtifactAsRead() {
        if !artifact.isRead {
            store.markAsRead(artifact)
        }
    }
}

extension ArtifactDetailView {
    var body: some View {
        ZStack {
            WebView(
                urlString: artifact.url.isEmpty
                    ? "https://google.com" : artifact.url
            )
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: { showNoteEditor.toggle() }) {
                    Label("Notes", systemImage: "pencil.and.list.clipboard")
                }
            }
        }
        .onAppear {
            markArtifactAsRead()
            notes = artifact.notes ?? ""
        }
        .sheet(isPresented: $showNoteEditor) {
            ArtifactNotesEditorView(
                notes: $notes,
                artifact: artifact
            )
            .environment(summarizeService)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 10)
                .onChanged { _ in
                    markArtifactAsRead()
                }
        )
    }
}

#Preview {
    NavigationStack {
        ArtifactDetailView(
            artifact: Artifact.mock
        )
        .environment(
            SummarizeService(
                model: GenerativeModel(
                    name: "gemini-2.0-flash-exp",
                    apiKey: APIKey.default
                )
            )
        )
    }
}
