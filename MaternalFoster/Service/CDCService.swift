//
//  CDCService.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import Foundation

struct CDCContent {
    let title: String
    let html: String
    let sourceURL: URL
}

struct CDCResourceTopic: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let iconColorHex: String
}

final class CDCService {
    static let shared = CDCService()

    private init() {}
    
    // only for warnings page
    func fetchHearHerWarningSigns() async throws -> CDCContent {
        let mediaId = "419328"

        let urlString = "https://tools.cdc.gov/api/v2/resources/media/\(mediaId)/syndicate.json"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(CDCSyndicationResponse.self, from: data)

        guard let result = decoded.results,
              let html = result.content,
              !html.isEmpty else {
            throw URLError(.badServerResponse)
        }

        return CDCContent(
            title: result.name ?? "Urgent Pregnancy-Related Warning Signs",
            html: html,
            sourceURL: URL(string: "https://www.cdc.gov/hearher/news-media/article-urgent-warning-signs.html")!
        )
    }
    
    
    func fetchCDCResource(mediaId: String, fallbackTitle: String) async throws -> CDCContent {
        let urlString = "https://tools.cdc.gov/api/v2/resources/media/\(mediaId)/syndicate.json"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(CDCSyndicationResponse.self, from: data)

        guard let result = decoded.results,
              let html = result.content,
              !html.isEmpty else {
            throw URLError(.badServerResponse)
        }

        return CDCContent(
            title: result.name ?? fallbackTitle,
            html: html,
            sourceURL: URL(string: "https://tools.cdc.gov/medialibrary/index.aspx#/media/id/\(mediaId)")!
        )
    }
}

private struct CDCSyndicationResponse: Codable {
    let results: CDCSyndicationResult?
}

private struct CDCSyndicationResult: Codable {
    let name: String?
    let content: String?
}
