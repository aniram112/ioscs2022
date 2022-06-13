import Foundation
import UIKit
import Kingfisher

final class CharacterViewController: UIViewController {
    var scrollView = UIScrollView()
    
    struct Model {
        let cellModel: [InfoCell.Model]
        let name: String
        let image: UIImage
        let character: Character
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
        
        title = "Character"
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToFav))
        
        heart.isUserInteractionEnabled = true
        heart.addGestureRecognizer(tapGestureRecognizer)
        
        view.backgroundColor = .customWhite
        
        setupUI()
        updateInfo()
    }
    
    @objc func addToFav(sender: Any){
        if (!Storage.shared.favCharacters.contains(model.character)){
            heart.image = UIImage(systemName: "heart.fill")
            Storage.shared.favCharacters.append(model.character)
            Storage.shared.favImages.append(icon.image ?? UIImage())
            Storage.shared.addFavs()
            Storage.shared.addImages()

            appLogger.logger.log(level: .info, message: "adding to faves")
        } else{
            heart.image = UIImage(systemName: "heart")
            if let index = Storage.shared.favCharacters.firstIndex(of: model.character ) {
                Storage.shared.favCharacters.remove(at: index)
                Storage.shared.favImages.remove(at: index)
                Storage.shared.addFavs()
                Storage.shared.addImages()

            }
        }
        
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        
        //scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)
        //scrollView.frame = view.bounds
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.addSubview(icon)
        containerView.addSubview(nameLabel)
        containerView.addSubview(heart)
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
            heart.widthAnchor.constraint(equalToConstant: 32),
            heart.heightAnchor.constraint(equalToConstant: 32),
            icon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            icon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 35),
            heart.topAnchor.constraint(equalTo: nameLabel.topAnchor,constant: 5),
            heart.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor,constant: 20),
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
        icon.image = model.image
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
        ret.layer.borderWidth = 1.0
        ret.layer.borderColor = (UIColor.black).cgColor
        ret.layer.masksToBounds = true
        ret.contentMode = .scaleAspectFill
        return ret
    }()
    
    private lazy var heart: UIImageView = {
        let ret = UIImageView()
        ret.image = UIImage(systemName: "heart")
        if (Storage.shared.favCharacters.contains(model.character)){
            ret.image = UIImage(systemName: "heart.fill")
        }
        ret.tintColor = .customBlack
        return ret
    }()
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.font = .largeTitleBold
        ret.numberOfLines = 1
        ret.textColor = .customBlack
        return ret
    }()
    
    private lazy var infoCells = [InfoCell(),InfoCell(),InfoCell()]
}
