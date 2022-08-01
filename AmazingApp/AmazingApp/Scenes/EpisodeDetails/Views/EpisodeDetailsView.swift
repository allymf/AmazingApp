//
//  EpisodeDetailsView.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import UIKit

protocol EpisodeDetailsViewModel {
    var posterPath: String { get }
    var name: String { get }
    var seasonAndEpisodeNumberText: String { get }
    var summary: String { get }
}

protocol EpisodeDetailsViewProtocol: ViewInitializer {
    var viewModel: EpisodeDetailsViewModel? { get set }
}

final class EpisodeDetailsView: UIView, EpisodeDetailsViewProtocol {
    var viewModel: EpisodeDetailsViewModel?
}
