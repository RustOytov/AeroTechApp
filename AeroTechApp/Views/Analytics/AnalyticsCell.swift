import UIKit

class AnalyticsCell: UICollectionViewCell {
    let container: UIView = {
        let cont = UIView()
        cont.backgroundColor = .bgCell
        cont.contentMode = .scaleToFill
        cont.layer.cornerRadius = 20
        cont.clipsToBounds = true
        cont.translatesAutoresizingMaskIntoConstraints = false
        return cont
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let secondDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.4
        label.font = .systemFont(ofSize: 13)
        label.contentMode = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubviews()
        makeConstraints()
    }
    
    //MARK: - setSubviews

    func setSubviews() {
        let subviews = [container, nameLabel, secondDateLabel]
        for i in subviews {
            contentView.addSubview(i)
        }
    }
    
    //MARK: - makeConstraints

    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            
            secondDateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 3),
            secondDateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)

        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
