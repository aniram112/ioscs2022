import UIKit

final class InfoCell: UIView {
    
    struct Model {
        let key: String
        let value: String
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(with model: Model) {
        infoKeyLabel.text = model.key
        infoValueLabel.text = model.value
    }
    
    private func setup() {
        //backgroundColor = .purple
        let stack = UIStackView()
        addSubview(stack)
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .left
        stack.axis = .vertical
        stack.spacing = 0
        
        stack.addArrangedSubview(infoKeyLabel)
        stack.addArrangedSubview(infoValueLabel)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        separator.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 5).isActive = true
        //separator.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separator.backgroundColor = .black
        separator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
    }
    
    
    private let infoKeyLabel: UILabel = {
        let ret = UILabel()
        ret.font = .title2
        ret.textColor = .gray
        ret.numberOfLines = 1
        return ret
    }()
    
    private let infoValueLabel: UILabel = {
        let ret = UILabel()
        ret.font = .title2
        ret.textColor = .black
        ret.numberOfLines = 1
        return ret
    }()
}

