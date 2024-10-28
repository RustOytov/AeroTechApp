import UIKit

//MARK: - FlightsVC

class FlightsVC: UIViewController, AddFlightsVCDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - bgView
    
    let bgView: UIView = {
        let container = UIView()
        
        let image = UIImageView()
        image.image = .nearstFlights
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(image)
        
        let mainLabel = UILabel()
        mainLabel.text = "Nearest flights"
        mainLabel.textColor = .white
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainLabel)
        
        let secondLabel = UILabel()
        secondLabel.numberOfLines = 0
        secondLabel.text = "Fill out the nearest flights to \n       check the aircraft"
        secondLabel.textColor = .white
        secondLabel.alpha = 0.4
        secondLabel.font = .systemFont(ofSize: 16)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 13),
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 52),
            image.widthAnchor.constraint(equalToConstant: 80),
            
            mainLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 13),
            mainLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 6),
            secondLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    //MARK: - addButton
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add nearest flights", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .redButton
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    var itemsFlights: [ItemFlights] = []
    var collectionView: UICollectionView!
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .bg
        titleContainers(view: self.view, name: "Flights")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FlightsCell.self, forCellWithReuseIdentifier: "FlightsCell")
        collectionView.backgroundColor = .bg
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        setSubviews()
        makeConstraints()
        if !itemsFlights.isEmpty {
            bgView.isHidden = true
        } else { bgView.isHidden = false }
    }
    //MARK: - setSubviews

    func setSubviews() {
        view.addSubview(bgView)
        view.addSubview(addButton)
    }
    //MARK: - makeConstraints

    func makeConstraints() {
        NSLayoutConstraint.activate([
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bgView.widthAnchor.constraint(equalToConstant: 230),
            bgView.heightAnchor.constraint(equalToConstant: 130),
            
            addButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 55),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            collectionView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    //MARK: - addFlights
    
    func addFlights(with name: String, checkDate: String) {
        itemsFlights.append(ItemFlights(name: name, checkDate: checkDate))
        if !itemsFlights.isEmpty {
            bgView.isHidden = true
        }
        collectionView.reloadData()
    }
    
    //MARK: - addButtonTapped

    @objc private func addButtonTapped() {
        let add = AddFlightsVC()
        add.delegate = self
        let navController = UINavigationController(rootViewController: add)
        present(navController, animated: true, completion: nil)
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FlightsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsFlights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightsCell", for: indexPath) as! FlightsCell
        cell.nameLabel.text = itemsFlights[indexPath.row].name
        cell.secondDateLabel.text = "Check before \(itemsFlights[indexPath.row].checkDate)"
        cell.parentViewController = self
            
            cell.buttonAction = {
                let checking = CheckingFlightsVC()
                let navController = UINavigationController(rootViewController: checking)
                checking.name = self.itemsFlights[indexPath.row].name
                checking.dateVer = self.itemsFlights[indexPath.row].checkDate
                cell.parentViewController?.present(navController, animated: true, completion: nil)
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
