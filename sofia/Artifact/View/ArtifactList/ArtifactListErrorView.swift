//
//  ArtifactListErrorView.swift
//  sofia
//
//  Created by Henrique on 15/04/25.
//
import SwiftUI

struct ArtifactListErrorView: View {
    let message: String
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)

            Text("Ocorreu um erro")
                .font(.title2)
                .bold()

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .padding()
    }
}
