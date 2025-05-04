import SwiftUI

struct ArtifactListSuccessView: View {
    let artifacts: [Artifact]
    @EnvironmentObject var artifactViewModel: ArtifactViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var showAddArtifact: Bool
    @Binding var showAuthDialog: Bool

    var body: some View {
        List(artifacts) { artifact in
            ArtifactListRowView(
                title: artifact.title,
                subtitle: artifact.siteName ?? "",
                extraInfo: artifact.createdAt.dateFormat(),
                summary: artifact.excerpt ?? "",
                isRead: artifact.isRead,
                isFlagged: artifact.isFlagged
            )
            .navigationLink(value: artifact, hideChevron: true)
            .swipeActions(edge: .leading) {
                Button {
                    artifactViewModel.toggleRead(artifact)
                } label: {
                    Label(
                        artifact.isRead ? "Unread" : "Read",
                        systemImage: artifact.isRead
                            ? "envelope.fill" : "envelope.badge.fill"
                    )
                }.tint(.blue)
            }
            .swipeActions {
                Button(role: .destructive) {
                    artifactViewModel.remove(artifact)
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }

                Button {
                    artifactViewModel.toggleFlagged(artifact)
                } label: {
                    Label("Favourite", systemImage: "star.fill")
                }.tint(.orange)
            }
        }
        .listStyle(.plain)
        .navigationTitle(authViewModel.isLoggedIn ? "Logado" : "Deslogado")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAuthDialog.toggle()
                } label: {
                    Image(systemName: "person.circle")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Add", systemImage: "plus") {
                    showAddArtifact.toggle()
                }
            }
        }
        .sheet(isPresented: $showAddArtifact) {
            AddArtifactDialog().environmentObject(artifactViewModel)
        }
        .sheet(isPresented: $showAuthDialog) {
            SignInView().environmentObject(authViewModel)
        }
    }
}
