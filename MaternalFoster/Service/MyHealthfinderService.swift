//
//  MyHealthfinderService.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import Foundation

struct HealthTopic: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let iconColorHex: String
}

struct MyHealthSection: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct MyHealthTopicDetail {
    let title: String
    let lastUpdated: String
    let sections: [MyHealthSection]
    let sourceURL: URL
    let logoURL: URL?
}

final class MyHealthfinderService {
    static let shared = MyHealthfinderService()

    private init() {}

    func fetchTopic(topicId: String) async throws -> MyHealthTopicDetail {
        let urlString = "https://odphp.health.gov/myhealthfinder/api/v4/topicsearch.json?TopicId=\(topicId)&Lang=en"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(MyHealthfinderResponse.self, from: data)

        guard let resource = decoded.result.resources?.resource?.first else {
            throw URLError(.badServerResponse)
        }

        let sections = resource.sections?.section?.compactMap { section in
            guard let content = section.content else { return nil }

            return MyHealthSection(
                title: section.title ?? "",
                content: content
            )
        } ?? []

        return MyHealthTopicDetail(
            title: resource.title ?? "Health Topic",
            lastUpdated: resource.lastUpdate ?? "Not available",
            sections: sections as! [MyHealthSection],
            sourceURL: URL(string: resource.healthfinderUrl ?? "https://odphp.health.gov/myhealthfinder")!,
            logoURL: URL(string: resource.healthfinderLogo ?? "")
        )
    }
}

private struct MyHealthfinderResponse: Codable {
    let result: MyHealthfinderResult

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

private struct MyHealthfinderResult: Codable {
    let resources: MyHealthfinderResources?

    enum CodingKeys: String, CodingKey {
        case resources = "Resources"
    }
}

private struct MyHealthfinderResources: Codable {
    let resource: [MyHealthfinderResource]?

    enum CodingKeys: String, CodingKey {
        case resource = "Resource"
    }
}

private struct MyHealthfinderResource: Codable {
    let title: String?
    let lastUpdate: String?
    let sections: MyHealthfinderSections?
    let healthfinderLogo: String?
    let healthfinderUrl: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case lastUpdate = "LastUpdate"
        case sections = "Sections"
        case healthfinderLogo = "HealthfinderLogo"
        case healthfinderUrl = "HealthfinderUrl"
    }
}

private struct MyHealthfinderSections: Codable {
    let section: [MyHealthfinderSection]?

    enum CodingKeys: String, CodingKey {
        case section = "section"
    }
}

private struct MyHealthfinderSection: Codable {
    let title: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case content = "Content"
    }
}
