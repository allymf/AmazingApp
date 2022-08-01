//
//  EpisodeDetailsPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol EpisodeDetailsPresentationLogic {
    func presentEpisodeDetails(response: EpisodeDetails.FetchEpisodeDetails.Response.Success)
}

final class EpisodeDetailsPresenter: EpisodeDetailsPresentationLogic {
    weak var viewController: EpisodeDetailsDisplayLogic?
    
    func presentEpisodeDetails(response: EpisodeDetails.FetchEpisodeDetails.Response.Success) {}
    
}
