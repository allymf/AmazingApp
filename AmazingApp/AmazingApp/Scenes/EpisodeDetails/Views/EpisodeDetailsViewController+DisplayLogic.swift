//
//  EpisodeDetailsViewController+DisplayLogic.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol EpisodeDetailsDisplayLogic: AnyObject {
    func displayEpisodeDetails(viewModel: EpisodeDetails.FetchEpisodeDetails.ViewModel.Success)
}

extension EpisodeDetailsViewController: EpisodeDetailsDisplayLogic {
    func displayEpisodeDetails(viewModel: EpisodeDetails.FetchEpisodeDetails.ViewModel.Success) {
        viewProtocol.viewModel = viewModel.episodeViewModel
    }
}
