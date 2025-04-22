//
//  ArtifactListRowView.swift
//  sofia
//
//  Created by Henrique on 06/03/25.
//
import SwiftUI

struct ArtifactListRowView: View {
    var title: String
    var subtitle: String
    var extraInfo: String
    var summary: String
    var isRead: Bool = false
    var isFlagged: Bool = false
}

extension ArtifactListRowView {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Circle()
                .fill(Color.blue)
                .frame(width: 10, height: 10)
                .opacity(isRead ? 0 : 1)
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(title)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(extraInfo)
                        .foregroundStyle(.secondary)
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text(subtitle)
                        .font(.subheadline)
                        .lineLimit(1)
                    Spacer()

                    Image(systemName:  isFlagged ? "star.fill" : "star")
                        .foregroundStyle(.secondary)
                }
                Text(summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List(0..<5) { _ in
            let artifact = Artifact.mock
            ArtifactListRowView(
                title: artifact.title,
                subtitle: artifact.siteName ?? "",
                extraInfo: artifact.createdAt.dateFormat(),
                summary: artifact.excerpt ?? "",
                isRead: artifact.isRead,
                isFlagged: artifact.isFlagged
            )
            ArtifactListRowView(
                title: artifact.title,
                subtitle: artifact.siteName ?? "",
                extraInfo: artifact.createdAt.dateFormat(),
                summary: artifact.excerpt ?? "",
                isRead: false,
                isFlagged: true
            )
        }.listStyle(.plain)
    }
}
