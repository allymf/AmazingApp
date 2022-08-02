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
            timeText: makeScheduleText(for: response.show.schedule),
            genresText: genresText,
            summary: response.show.summary?.removeHTMLMarks() ?? String()
        )
        
        viewController?.displayShowDetails(viewModel: .init(headerViewModel: headerViewModel))
    }
    
    func presentShowSeasons(response: ShowDetails.FetchShowSeasons.Response.Success) {
        let seasonsViewModel = makeSeasonsViewModel(with: response.episodes)
        viewController?.displayShowSeasons(viewModel: .init(seasonViewModels: seasonsViewModel))
    }
    
    func presentShowSeasonsFailure(response: ShowDetails.FetchShowSeasons.Response.Failure) {
        viewController?.displayShowSeasonsFailure(viewModel: .init(error: response.error))
    }
    
    private func makeSeasonsViewModel(with episodes: [Episode]) -> [ShowDetails.SeasonViewModel] {
        let episodeViewModels = episodes.map { makeEpisodeViewModel(from: $0) }
        
        let seasons: [ShowDetails.SeasonViewModel] = episodeViewModels.reduce([]) { partialResult, episodeViewModel in
            guard let existingSeasonIndex = partialResult.firstIndex(where: { $0.number == episodeViewModel.season }) else {
                let newSeasonViewModel = ShowDetails.SeasonViewModel(
                    seasonTitle: "Season \(episodeViewModel.season)",
                    number: episodeViewModel.season,
                    episodes: [episodeViewModel]
                )
                return partialResult + [newSeasonViewModel]
            }
            
            var newResult = partialResult
            
            newResult[existingSeasonIndex].episodes.append(episodeViewModel)
            return newResult
        }
        
        return seasons
    }
    
    private func makeEpisodeViewModel(from episode: Episode) -> ShowDetails.EpisodeViewModel {
        var rating = "-"
        if let showRating = episode.rating?.average {
            rating = "\(showRating)"
        }
        return .init(
            posterPath: episode.image?.medium ?? String(),
            name: episode.name ?? String(),
            rating: " ⭑ \(rating) ",
            season: episode.season ?? 0
        )
    }
    
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
