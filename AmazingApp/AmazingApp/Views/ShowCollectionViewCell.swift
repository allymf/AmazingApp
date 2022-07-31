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
        
        label.font = .systemFont(
            ofSize: 17,
            weight: .bold
        )
        label.textColor = .black
        label.text = "Nome"
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(
            ofSize: 12,
            weight: .thin
        )
        label.textColor = .black
        label.text = "Genero, Genero"
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
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
        contentView.backgroundColor = .cyan
        addSubviews()
        constrainSubviews()
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
                descriptionContainerView.heightAnchor.constraint(equalToConstant: 50),
                descriptionContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                descriptionContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                descriptionContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                descriptionStackView.topAnchor.constraint(
                    equalTo: descriptionContainerView.topAnchor,
                    constant: 8
                ),
                descriptionStackView.leadingAnchor.constraint(
                    equalTo: descriptionContainerView.leadingAnchor,
                    constant: 16
                ),
                descriptionStackView.trailingAnchor.constraint(
                    equalTo: descriptionContainerView.trailingAnchor,
                    constant: -16
                ),
                descriptionStackView.bottomAnchor.constraint(
                    equalTo: descriptionContainerView.bottomAnchor,
                    constant: -8
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
}
