import Foundation
import UIKit
import Kingfisher

final class CharacterViewController: UIViewController {
    var scrollView = UIScrollView()
    
    struct Model {
        let cellModel: [InfoCell.Model]
        let name: String
        let imageURL: URL
    }
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        
        
        view.backgroundColor = .white
        
        setupUI()
        updateInfo()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        
        //scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)
        //scrollView.frame = view.bounds
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.addSubview(icon)
        containerView.addSubview(nameLabel)
        scrollView.showsVerticalScrollIndicator = false
        
        infoCells.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //scrollView.backgroundColor = .cyan
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo:scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor,constant: 10).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        //containerView.backgroundColor = .purple
        
        containerView.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 300),
            icon.heightAnchor.constraint(equalToConstant: 300),
            icon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            icon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
        
        infoCells[0].topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40).isActive = true
        var prevCell = infoCells[0]
        infoCells.forEach{ cell in
            if cell != prevCell{
                cell.topAnchor.constraint(equalTo: prevCell.bottomAnchor, constant: 40).isActive = true
                prevCell = cell
            }
        }
        infoCells.forEach{
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
            $0.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -32).isActive = true
        }
        
    }
    
    private func updateInfo() {
        icon.kf.setImage(with: model.imageURL)
        nameLabel.text = model.name
        var ind = 0
        infoCells.forEach{
            $0.update(with: model.cellModel[ind])
            ind = ind + 1
        }
        //infoCells.update(with: model.statusModel)
    }
    
    private let model: Model
    
    private lazy var icon: UIImageView = {
        let ret = UIImageView()
        ret.layer.cornerRadius = 10
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 34)
        ret.numberOfLines = 1
        ret.textColor = .main
        return ret
    }()
    
    private lazy var infoCells = [InfoCell(),InfoCell(),InfoCell()]
}
