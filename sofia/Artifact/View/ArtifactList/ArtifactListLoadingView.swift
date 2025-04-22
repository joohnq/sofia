//
//  ArtifactListLoadingView.swift
//  sofia
//
//  Created by Henrique on 15/04/25.
//
import SwiftUI

struct ArtifactListLoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}
