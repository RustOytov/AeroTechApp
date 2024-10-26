import UIKit
class MaintenanceCell: UICollectionViewCell {
    let container: UIView = {
        let cont = UIView()
        cont.backgroundColor = .bgCell
        cont.contentMode = .scaleToFill
        cont.layer.cornerRadius = 20
        cont.clipsToBounds = true
        cont.translatesAutoresizingMaskIntoConstraints = false
        return cont
    }()
    let plane: UIImageView = {
        let image = UIImageView()
        image.image = .plane
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let namePlane: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let modelPlane: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.4
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubviews()
        makeConstraints()
    }
    func setSubviews() {
        contentView.addSubview(container)
        contentView.addSubview(plane)
        contentView.addSubview(namePlane)
        contentView.addSubview(modelPlane)
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            plane.topAnchor.constraint(equalTo: container.topAnchor, constant: 22),
            plane.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            plane.widthAnchor.constraint(equalToConstant: 150),
            plane.heightAnchor.constraint(equalToConstant: 55),
            
            namePlane.topAnchor.constraint(equalTo: plane.topAnchor, constant: 5),
            namePlane.leadingAnchor.constraint(equalTo: plane.trailingAnchor, constant: 10),
            namePlane.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            modelPlane.topAnchor.constraint(equalTo: namePlane.bottomAnchor, constant: 5),
            modelPlane.leadingAnchor.constraint(equalTo: namePlane.leadingAnchor),
            modelPlane.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
