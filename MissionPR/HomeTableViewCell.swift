import UIKit

enum HomeConstraintConstants: CGFloat {
    case iconImageViewHeight = 60
    case disclosureImageViewHeight = 40
}

final class HomeTableViewCell: UITableViewCell, ConfigurableCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.alpha = 0.5
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.alpha = 0.5
        imageView.layer.masksToBounds = true
        imageView.image = AppImage.get(.arrowRight)
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var cellImage: UIImage?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: HomeCellViewModel) {
        titleLabel.text = viewModel.title
        iconImageView.image = viewModel.image
    }
}

extension HomeTableViewCell {
    
    private func initialize() {
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: contentView.topAnchor), containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16), containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: HomeConstraintConstants.iconImageViewHeight.rawValue),
            iconImageView.widthAnchor.constraint(equalToConstant: HomeConstraintConstants.iconImageViewHeight.rawValue),
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)])
        
        iconImageView.layer.cornerRadius = HomeConstraintConstants.iconImageViewHeight.rawValue / 2
        
        containerView.addSubview(disclosureImageView)
        NSLayoutConstraint.activate([
            disclosureImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            disclosureImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            disclosureImageView.heightAnchor.constraint(equalToConstant: HomeConstraintConstants.disclosureImageViewHeight.rawValue),
            disclosureImageView.widthAnchor.constraint(equalToConstant: HomeConstraintConstants.disclosureImageViewHeight.rawValue)
        ])
        
        disclosureImageView.layer.cornerRadius = HomeConstraintConstants.disclosureImageViewHeight.rawValue / 2
        
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: disclosureImageView.leadingAnchor, constant: -16.0)
        ])
    }
}
