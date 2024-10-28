import UIKit

class FlightsCell: UICollectionViewCell {
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start checking", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .redButton
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var parentViewController: UIViewController?
    var buttonAction: (() -> Void)?
    //MARK: - init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubviews()
        makeConstraints()
    }
    
    //MARK: - setSubviews

    func setSubviews() {
        let subviews = [container, nameLabel, secondDateLabel, startButton]
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
            
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            
            secondDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            secondDateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            startButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: secondDateLabel.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 51),
            startButton.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    @objc private func startButtonTapped() {
        buttonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
