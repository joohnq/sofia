import Foundation
import SwiftUI

struct AddArtifactDialog: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var artifactViewModel: ArtifactViewModel
    @Environment(MetadataService.self) private var metadataService
    @State var url: String = ""
    @State var title: String = ""

    @State private var artifact: Artifact = Artifact(title: "", url: "")

    func updateMetadata() async {
        do {
            let metadata = try await metadataService.fetchMetadata(
                for: artifact.url)
            artifact.title =
                artifact.title.isEmpty
                ? metadata.metaTitle ?? "" : artifact.title
            artifact.imageUrl =
                (artifact.imageUrl?.isEmpty ?? true)
                ? metadata.metaImage ?? "" : artifact.imageUrl
            artifact.siteName =
                (artifact.siteName?.isEmpty ?? true)
                ? metadata.siteName ?? "" : artifact.siteName
            artifact.author =
                (artifact.author?.isEmpty ?? true)
                ? metadata.metaAuthor ?? "" : artifact.author
            artifact.excerpt =
                (artifact.excerpt?.isEmpty ?? true)
                ? metadata.metaDescription ?? "" : artifact.excerpt
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension AddArtifactDialog {
    var body: some View {
        NavigationStack {
            List {
                Section("URL") {
                    TextField("Required", text: $artifact.url)
                        .textContentType(.URL)
                        .textInputAutocapitalization(.never)
                        .onChange(
                            of: artifact.url,
                            { old, new in
                                Task {
                                    await updateMetadata()
                                }
                            }
                        )
                }
                Section("Title") {
                    TextField("Optional", text: $artifact.title)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Add Artifact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { dismiss() })
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", action: { artifactViewModel.add(artifact) })
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddArtifactDialog()
    }
}
