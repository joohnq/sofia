import Foundation
import GoogleGenerativeAI
import SwiftUI

struct ArtifactNotesEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(SummarizeService.self) var summarizeService
    @Binding var notes: String
    var artifact: Artifact

    func summarize() {
        Task {
            let summary: String

            do {
                summary = try await summarizeService.summarize(artifact.fullText ?? "")
            } catch {
                summary = error.localizedDescription
            }

            notes += "\n\n" + summary
        }
    }
}

extension ArtifactNotesEditorView {
    var body: some View {
        NavigationStack {
            Divider()
                .frame(minHeight: 1)

            TextEditor(text: $notes)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 8)
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { summarize() }) {
                            Image(systemName: "wand.and.stars")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: { dismiss() }) {
                            Text("Done")
                        }
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var note: String =
        "Shoot all the bluejays you want, if you can hit 'em, but remember it's a sin to kill a mockingbird."
    NavigationStack {
        ArtifactNotesEditorView(
            notes: $note,
            artifact: Artifact.mock
        ).environment(
            SummarizeService(
                model: GenerativeModel(
                    name: "gemini-2.0-flash-exp",
                    apiKey: APIKey.default
                )
            )
        )
    }
}
