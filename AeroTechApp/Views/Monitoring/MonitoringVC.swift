import UIKit

protocol EditMonitoringVCDelegate: AnyObject {
    func didUpdateMonItem (at index: Int, with name: String, weight: String, balance: Bool, temperature: String, airPressure: String, fuelConsumption: String)
}
protocol DeleteMonitoringItemDelegate: AnyObject {
    func didDeleteMonItem (at indexPath: IndexPath)
}

//MARK: - MonitoringVC
class MonitoringVC: UIViewController, UICollectionViewDelegateFlowLayout, AddMonParDelegate, EditMonitoringVCDelegate, DeleteMonitoringItemDelegate {
    
    //MARK: - bgView
    
    let bgView: UIView = {
        let container = UIView()
        
        let image = UIImageView()
        image.image = .tools
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(image)
        
        let mainLabel = UILabel()
        mainLabel.numberOfLines = 0
        mainLabel.text = "Monitoring of \n  parameters"
        mainLabel.textColor = .white
        mainLabel.font = .boldSystemFont(ofSize: 22)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainLabel)
        
        let secondLabel = UILabel()
        secondLabel.text = "Track all aircraft parameters"
        secondLabel.textColor = .white
        secondLabel.alpha = 0.4
        secondLabel.font = .systemFont(ofSize: 18)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 71.5),
            image.widthAnchor.constraint(equalToConstant: 71.5),
            
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
        button.setTitle("Add monitoring of parameters", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .redButton
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var collectionView: UICollectionView!
    var monItems: [ItemMonitoring] = []
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        view.backgroundColor = .bg
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MonitoringCell.self, forCellWithReuseIdentifier: "MonitoringCell")
        collectionView.backgroundColor = .bg
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        titleContainers(view: self.view, name: "Monitoring")
        
        setSubviews()
        makeConstraints()
        
        if !monItems.isEmpty {
            bgView.isHidden = true
        }
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
    //MARK: - addMP
    
    func addMP(name: String, weight: String, balance: Bool, temperature: String, airPressure: String, fuelConsumption: String) {
        let newMonItem = ItemMonitoring(name: name, weight: weight, balance: balance,
                                        temperature: temperature, airPressure: airPressure, fuelConsumption: fuelConsumption)
        monItems.append(newMonItem)
        if !monItems.isEmpty {
            bgView.isHidden = true
        }
        collectionView.reloadData()
    }
    //MARK: - didUpdateMonItem

    func didUpdateMonItem(at index: Int, with name: String, weight: String, balance: Bool, temperature: String, airPressure: String, fuelConsumption: String) {
        monItems[index] = ItemMonitoring(name: name, weight: weight, balance: balance,
                                         temperature: temperature, airPressure: airPressure, fuelConsumption: fuelConsumption)
        collectionView.reloadData()
    }
    //MARK: - didDeleteMonItem

    func didDeleteMonItem(at indexPath: IndexPath) {
        monItems.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        if monItems.isEmpty {
            bgView.isHidden = false
        }
        collectionView.reloadData()
    }
    //MARK: - addButtonTapped

    @objc private func addButtonTapped() {
        let add = AddMonParVC()
        add.delegate = self
        let navCont = UINavigationController(rootViewController: add)
        present(navCont, animated: true, completion: nil)
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MonitoringVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        monItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonitoringCell", for: indexPath) as! MonitoringCell
        cell.namePlane.text = monItems[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = ShowMonitoringVC()
        show.monItem = monItems[indexPath.row]
        show.editMonDelegate = self
        show.deleteMonDelegate = self
        show.monIndexPath = indexPath
        show.monIndex = indexPath.row
        let navCont = UINavigationController(rootViewController: show)
        present(navCont, animated: true, completion: nil)
    }
}
