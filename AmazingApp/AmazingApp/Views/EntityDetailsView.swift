//
//  EntityDetailsView.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol EntityDetailsViewModel {
    var bannerPath: String { get }
    var iconPath: String { get }
    var name: String { get }
    var subtitle: String { get }
    var headline: String { get }
    var summary: String { get }
}

final class EntityDetailsView: UIView {
    
    var viewModel: EntityDetailsViewModel? {
        didSet {
            horizontalPosterImageView.imagePath = viewModel?.bannerPath ?? ""
            posterImageView.imagePath = viewModel?.iconPath ?? ""
            nameLabel.text = viewModel?.name
            subtitleLabel.text = viewModel?.subtitle
            headlineLabel.text = viewModel?.headline
            summaryLabel.text = viewModel?.summary
        }
    }
    
    var posterImageViewWidthConstraintHidden: NSLayoutConstraint?
    var posterImageViewWidthConstraint: NSLayoutConstraint?
    
    private let horizontalPosterImageView: AmazingImageView = {
        let imageView = AmazingImageViewFactory.makeView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private let posterImageView: AmazingImageView = {
        let imageView = AmazingImageViewFactory.makeView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = Metrics.NameLabel.font
        label.numberOfLines = Metrics.NameLabel.numberOfLines
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Metrics.GenreLabel.font
        label.numberOfLines = Metrics.GenreLabel.numberOfLines
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        
        label.font = Metrics.AirTimeLabel.font
        label.numberOfLines = Metrics.AirTimeLabel.numberOfLines
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        
        label.font = Metrics.SummaryLabel.font
        label.numberOfLines = Metrics.SummaryLabel.numberOfLines
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Metrics.DescriptionStackView.verticalMargin
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        
        label.font = Metrics.RatingLabel.font
        label.numberOfLines = Metrics.RatingLabel.numberOfLines
        label.backgroundColor = .white
        label.layer.cornerRadius = Metrics.RatingLabel.cornerRadius
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addSubviews()
        constrainSubviews()
        additionalconfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(horizontalPosterImageView)
        addSubview(posterImageView)
        addSubview(ratingLabel)
        addSubview(summaryLabel)
        addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(nameLabel)
        descriptionStackView.addArrangedSubview(headlineLabel)
        descriptionStackView.addArrangedSubview(subtitleLabel)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate(
            [
                horizontalPosterImageView.topAnchor.constraint(equalTo: topAnchor),
                horizontalPosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                horizontalPosterImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                horizontalPosterImageView.heightAnchor.constraint(equalToConstant: Metrics.HorizontalPosterImageView.height)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                ratingLabel.topAnchor.constraint(
                    equalTo: horizontalPosterImageView.topAnchor,
                    constant: Metrics.RatingLabel.verticalMargin
                ),
                ratingLabel.leadingAnchor.constraint(
                    equalTo: horizontalPosterImageView.leadingAnchor,
                    constant: Metrics.RatingLabel.horizontalMargin
                ),
            ]
        )
        
        posterImageViewWidthConstraintHidden = posterImageView.widthAnchor.constraint(equalToConstant: 0)
        posterImageViewWidthConstraint = posterImageView.widthAnchor.constraint(equalToConstant: Metrics.PosterImageView.width)
        
        posterImageViewWidthConstraint?.isActive = true
        
        NSLayoutConstraint.activate(
            [
                posterImageView.topAnchor.constraint(equalTo: horizontalPosterImageView.bottomAnchor, constant: Metrics.PosterImageView.verticalMargin),
                posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.PosterImageView.horizontalMargin),
                posterImageView.heightAnchor.constraint(equalToConstant: Metrics.PosterImageView.height)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                descriptionStackView.topAnchor.constraint(equalTo: horizontalPosterImageView.bottomAnchor, constant: Metrics.DescriptionStackView.verticalMargin),
                descriptionStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: Metrics.DescriptionStackView.horizontalMargin),
                descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.DescriptionStackView.horizontalMargin),
                descriptionStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                summaryLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: Metrics.SummaryLabel.verticalMargin),
                summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.SummaryLabel.horizontalMargin),
                summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.SummaryLabel.horizontalMargin),
                summaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.SummaryLabel.verticalMargin)
            ]
        )
    }
    
    func additionalconfigurations() {
        ratingLabel.clipsToBounds = true
        ratingLabel.layer.cornerRadius = Metrics.RatingLabel.cornerRadius
    }
    
    func hideImage() {
        posterImageView.isHidden = true
        posterImageViewWidthConstraint?.isActive = false
        posterImageViewWidthConstraintHidden?.isActive = true
    }
}

extension EntityDetailsView {
    enum Metrics {
        
        enum HorizontalPosterImageView {
            static let height: CGFloat = 150
        }
        
        enum PosterImageView {
            static let width: CGFloat = 100
            static let height: CGFloat = 130
            static let verticalMargin: CGFloat = 8
            static let horizontalMargin: CGFloat = 8
        }
        
        enum NameLabel {
            static let font = UIFont.systemFont(
                ofSize: 20,
                weight: .bold
            )
            static let numberOfLines = 2
        }
        
        enum GenreLabel {
            static let font = UIFont.systemFont(
                ofSize: 15,
                weight: .thin
            )
            static let numberOfLines = 1
        }
        
        enum AirTimeLabel {
            static let font = UIFont.systemFont(
                ofSize: 17,
                weight: .medium
            )
            static let numberOfLines = 1
        }
        
        enum SummaryLabel {
            static let font = UIFont.systemFont(
                ofSize: 17,
                weight: .regular
            )
            static let numberOfLines = 0
            static let verticalMargin: CGFloat = 16
            static let horizontalMargin: CGFloat = 8
        }
        
        enum RatingLabel {
            static let font = UIFont.systemFont(
                ofSize: 14,
                weight: .medium
            )
            static let numberOfLines = 1
            static let cornerRadius: CGFloat = 6
            static let verticalMargin: CGFloat = 8
            static let horizontalMargin: CGFloat = 8
        }
        
        enum DescriptionStackView {
            static let verticalMargin: CGFloat = 16
            static let horizontalMargin: CGFloat = 8
        }
        
    }
}

