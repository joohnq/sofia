//
//  MetadataService.swift
//  sofia
//
//  Created by Henrique on 07/03/25.
//
import Foundation
import OpenGraphReader
import Observation

@Observable
public class MetadataService {
    private let reader: OpenGraphReader

    public init(reader: OpenGraphReader) {
        self.reader = reader
    }

    func fetchMetadata(for urlString: String) async throws -> ArtifactMetadata {
        guard let url = URL(string: urlString) else {
            throw MetadataError.invalidURL
        }

        var metadata = ArtifactMetadata(url: urlString)

        do {
            let res = try await reader.fetch(url: url)
            metadata.metaTitle = res.title
            metadata.metaDescription = res.description
            metadata.metaAuthor = res.stringValue("author")
            metadata.metaImage = res.imageURL?.absoluteString
            metadata.siteName = res.siteName
        } catch {
            throw MetadataError.parsingError(error)
        }

        return metadata
    }
}
