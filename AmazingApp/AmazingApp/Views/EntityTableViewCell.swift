//
//  EntityTableViewCell.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol EntityCellViewModel {
    var imagePath: String { get }
    var title: String { get }
    var description: String { get }
}

final class EntityTableViewCell: UITableViewCell {
    
    // MARK: - Components
    private let iconImageView: AmazingImageView = {
        let iconImageView = AmazingImageViewFactory.makeView()
        
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = Metrics.IconImageView.cornerRadius
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconImageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.LabelStackView.verticalMargin
        stackView.distribution = .fillProportionally
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = Metrics.TitleLabel.font
        label.numberOfLines = Metrics.TitleLabel.numberOfLines
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = Metrics.DescriptionLabel.font
        label.numberOfLines = .zero
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Properties
    var viewModel: EntityCellViewModel? {
        didSet {
            iconImageView.imagePath = viewModel?.imagePath ?? String()
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
        }
    }
    
    // MARK: - Initialization
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.cancelImageFetch()
        iconImageView.image = UIImage()
        titleLabel.text = String()
        descriptionLabel.text = String()
    }
    
    func addSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
    }
    
    func constrainSubviews() {
        
        NSLayoutConstraint.activate(
            [
                iconImageView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Metrics.IconImageView.verticalMargin
                ),
                iconImageView.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: Metrics.IconImageView.horizontalMargin
                ),
                iconImageView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -Metrics.IconImageView.verticalMargin
                ),
                iconImageView.widthAnchor.constraint(equalToConstant: Metrics.IconImageView.width),
                iconImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: Metrics.IconImageView.height)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                labelsStackView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Metrics.LabelStackView.verticalMargin
                ),
                labelsStackView.leadingAnchor.constraint(
                    equalTo: iconImageView.trailingAnchor,
                    constant: Metrics.LabelStackView.horizontalMargin
                ),
                labelsStackView.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -Metrics.LabelStackView.horizontalMargin
                ),
                labelsStackView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -Metrics.LabelStackView.verticalMargin
                )
            ]
        )
        
    }
    

}

extension EntityTableViewCell {
    enum Metrics {
        enum IconImageView {
            static let cornerRadius: CGFloat = 10
            static let width: CGFloat = 120
            static let height: CGFloat = 80
            static let verticalMargin: CGFloat = 8
            static let horizontalMargin: CGFloat = 8
        }
        
        enum LabelStackView {
            static let verticalMargin: CGFloat = 8
            static let horizontalMargin: CGFloat = 8
        }
        
        enum TitleLabel {
            static let font = UIFont.systemFont(
                ofSize: 18,
                weight: .semibold
            )
            static let numberOfLines = 2
    }
        
        enum DescriptionLabel {
            static let font = UIFont.systemFont(
                ofSize: 14,
                weight: .regular
            )
        }
    }
}
