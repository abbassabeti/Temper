//
//  Job.swift
//  Temper
//
//  Created by Abbas on 2/11/21.
//
// MARK: - Job

struct Job: Codable {
    let id, title: String?
    let isAgency: Bool?
    let extraBriefing, dressCode: String?
    let tips: Bool?
    let slug: String?
    let links: JobLinks?
    let skills: [Appearance]?
    let project: Project?
    let category: Category?
    let reportTo: ReportTo?
    let appearances: [Appearance]?
    let reportAtAddress: ReportAtAddress?

    enum CodingKeys: String, CodingKey {
        case id, title
        case isAgency = "is_agency"
        case extraBriefing = "extra_briefing"
        case dressCode = "dress_code"
        case tips, slug
        case links, skills, project, category
        case reportTo = "report_to"
        case appearances
        case reportAtAddress = "report_at_address"
    }
}
