import UIKit

final class CircleButton: UIButton {
    
    var backgroundImage: UIImage?
    
    var title: String?
    
    var buttonColor: UIColor?
    
    var tapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented yet")
    }
    
    convenience init(title: String, image: UIImage, color: UIColor, action: (() -> Void)?) {
        let buttonHeight: CGFloat = 45.0
        let frame = CGRect(x: 0, y: 0, width: buttonHeight, height: buttonHeight)
        self.init(frame: frame)
        
        self.title = title
        self.backgroundImage = image
        self.buttonColor = color
        self.tapAction = action
        
        setupButton()
    }
    
    private func setupButton() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 5.0
        self.layer.backgroundColor = buttonColor?.cgColor
        self.setImage(backgroundImage, for: .normal)
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        tapAction?()
    }
}
