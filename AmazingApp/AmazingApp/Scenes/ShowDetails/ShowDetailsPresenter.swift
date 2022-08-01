//
//  ShowDetailsPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsPresentationLogic {
    func presentShowDetails(response: ShowDetails.FetchShowDetail.Response.Success)
    func presentShowSeasons(response: ShowDetails.FetchShowSeasons.Response.Success)
    func presentShowSeasonsFailure(response: ShowDetails.FetchShowSeasons.Response.Failure)
}

final class ShowDetailsPresenter: ShowDetailsPresentationLogic {
    weak var viewController: ShowDetailsDisplayLogic?
    
    func presentShowDetails(response: ShowDetails.FetchShowDetail.Response.Success) {
        
        let genresText = "Genre: " + (response.show.genres?.joined(separator: ", ") ?? "Unknown")
        
        let headerViewModel = ShowDetails.ShowDetailHeaderViewModel(
            iconPath: response.show.image?.medium ?? String(),
            bannerPath: response.show.image?.original ?? String(),
            name: response.show.name ?? "-",
            scheduleText: makeScheduleText(for: response.show.schedule),
            genresText: genresText,
            summary: response.show.summary ?? String()
        )
        
        viewController?.displayShowDetails(viewModel: .init(headerViewModel: headerViewModel))
    }
    
    func presentShowSeasons(response: ShowDetails.FetchShowSeasons.Response.Success) {
        
    }
    
    func presentShowSeasonsFailure(response: ShowDetails.FetchShowSeasons.Response.Failure) {}
    
    private func makeScheduleText(for schedule: Show.Schedule?) -> String {
        guard let schedule = schedule else {
            return String()
        }
        
        let daysText = schedule.days.compactMap {
            $0.abbreviation
        }.joined(separator: ", ")
        
        var scheduleText = daysText
        
        if let airTime = schedule.time {
            scheduleText += " at \(airTime)*"
        }
        
        return scheduleText
    }
    
}
