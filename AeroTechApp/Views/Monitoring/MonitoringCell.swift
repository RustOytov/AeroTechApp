import UIKit

class MonitoringCell: UICollectionViewCell {
    
    let cellContainer: UIView = {
        let cont = UIView()
        cont.backgroundColor = .bgCell
        cont.clipsToBounds = true
        cont.layer.cornerRadius = 20
        cont.layer.borderWidth = 2
        cont.layer.borderColor = UIColor.grayBorder.cgColor
        cont.translatesAutoresizingMaskIntoConstraints = false
        return cont
    }()
    
    let gearImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "gearshape.2")
        image.tintColor = .white
        image.alpha = 0.4
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let namePlane: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubviews()
        makeConstraints()
    }
    func setSubviews() {
        let subviews = [cellContainer,gearImage,namePlane,arrowImage]
        for i in subviews {
            contentView.addSubview(i)
        }
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            gearImage.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
            gearImage.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 17),
            gearImage.widthAnchor.constraint(equalToConstant: 38),
            gearImage.heightAnchor.constraint(equalToConstant: 31),
            
            namePlane.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
            namePlane.leadingAnchor.constraint(equalTo: gearImage.trailingAnchor, constant: 30),
            namePlane.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -45),
            
            arrowImage.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -41),
            arrowImage.heightAnchor.constraint(equalToConstant: 24),
            arrowImage.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
