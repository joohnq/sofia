enum MetadataError: Error {
    case invalidURL
    case fetchFailed
    case invalidResponse
    case parsingError(Error)
    case extractionError(String)
}
