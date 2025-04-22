//
//  MetadataError.swift
//  sofia
//
//  Created by Henrique on 10/03/25.
//
enum MetadataError: Error {
    case invalidURL
    case fetchFailed
    case invalidResponse
    case parsingError(Error)
    case extractionError(String)
}
