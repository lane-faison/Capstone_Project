import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    var cellImage: UIImage?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}

extension HomeTableViewCell {
    fileprivate func initialize() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0)
            ])
    }
}
