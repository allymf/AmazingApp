//
//  ShowDetailsPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsPresentationLogic {}

final class ShowDetailsPresenter: ShowDetailsPresentationLogic {
    weak var viewController: ShowDetailsDisplayLogic?
}
