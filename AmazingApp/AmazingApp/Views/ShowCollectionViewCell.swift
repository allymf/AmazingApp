//
//  ShowCollectionViewCell.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//

import UIKit

final class ShowCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
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
        label.text = "Nome"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        
        label.font = Metrics.GenreLabel.font
        label.numberOfLines = Metrics.GenreLabel.numberOfLines
        label.textColor = .black
        label.text = "Genero, Genero"
        
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
    
    private let descriptionContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(descriptionContainerView)
        descriptionContainerView.addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(nameLabel)
        descriptionStackView.addArrangedSubview(genreLabel)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate(
            [
                descriptionContainerView.heightAnchor.constraint(equalToConstant: Metrics.DescriptionContainerView.height),
                descriptionContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                descriptionContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                descriptionContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                descriptionStackView.topAnchor.constraint(
                    equalTo: descriptionContainerView.topAnchor,
                    constant: Metrics.DescriptionStackView.verticalMargin
                ),
                descriptionStackView.leadingAnchor.constraint(
                    equalTo: descriptionContainerView.leadingAnchor,
                    constant: Metrics.DescriptionStackView.horizontalMargin
                ),
                descriptionStackView.trailingAnchor.constraint(
                    equalTo: descriptionContainerView.trailingAnchor,
                    constant: -Metrics.DescriptionStackView.horizontalMargin
                ),
                descriptionStackView.bottomAnchor.constraint(
                    equalTo: descriptionContainerView.bottomAnchor,
                    constant: -Metrics.DescriptionStackView.verticalMargin
                )
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                posterImageView.bottomAnchor.constraint(equalTo: descriptionContainerView.topAnchor)
            ]
        )
    }
    
    func additionalconfigurations() {
        contentView.backgroundColor = .systemGray2
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Metrics.ContentView.cornerRadius
    }
    
}

extension ShowCollectionViewCell {
    enum Metrics {
        
        enum ContentView {
            static let cornerRadius: CGFloat = 10
        }
        
        enum NameLabel {
            static let font = UIFont.systemFont(
                ofSize: 17,
                weight: .bold
            )
            static let numberOfLines = 1
        }
        
        enum GenreLabel {
            static let font = UIFont.systemFont(
                ofSize: 12,
                weight: .thin
            )
            static let numberOfLines = 2
        }
        
        enum DescriptionStackView {
            static let verticalMargin: CGFloat = 8
            static let horizontalMargin: CGFloat = 16
        }
        
        enum DescriptionContainerView {
            static let height: CGFloat = 50
        }
        
    }
}
