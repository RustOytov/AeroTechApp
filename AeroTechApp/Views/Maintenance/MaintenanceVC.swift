import UIKit

//MARK: - EditVCDelegate

protocol EditVCDelegate: AnyObject {
    func didUpdateItem(at index: Int, with name: String, model: String, serialNumber: String, lastInsp: String, upcommingInsp: String)
}
//MARK: - DeleteItemDelegate

protocol DeleteItemDelegate: AnyObject {
    func didDeleteItem(at index: IndexPath)
}
//MARK: - Item

//struct Item {
//    var name: String
//    var model: String
//    var serialNumber: String
//    var lastInsp: String
//    var upcommingInsp: String
//}
let createButton: UIButton = {
    let button = UIButton()
    button.setTitle("Create aircraft", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.backgroundColor = .redButton
    button.layer.cornerRadius = 25
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}()
//MARK: - bgView
let bgView: UIView = {
    let container = UIView()
    
    let plane = UIImageView()
    plane.image = .plane
    plane.contentMode = .scaleAspectFill
    plane.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(plane)
    
    let firstLabel = UILabel()
    firstLabel.text = "Aircraft"
    firstLabel.textColor = .white
    firstLabel.font = .boldSystemFont(ofSize: 22)
    firstLabel.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(firstLabel)
    
    let secondLabel = UILabel()
    secondLabel.text = "Add your aircraft for maintenance"
    secondLabel.textColor = .white
    secondLabel.alpha = 0.4
    secondLabel.font = .systemFont(ofSize: 18)
    secondLabel.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(secondLabel)
    
    
    NSLayoutConstraint.activate([
        plane.topAnchor.constraint(equalTo: container.topAnchor),
        plane.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        plane.heightAnchor.constraint(equalToConstant: 55),
        plane.widthAnchor.constraint(equalToConstant: 150),
        
        firstLabel.topAnchor.constraint(equalTo: plane.bottomAnchor, constant: 13),
        firstLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        
        secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 6),
        secondLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        
    ])
    container.backgroundColor = .clear
    container.translatesAutoresizingMaskIntoConstraints = false
    return container
}()
//MARK: - MaintenanceVC

class MaintenanceVC: UIViewController, UICollectionViewDelegateFlowLayout, CreateDelegate, EditVCDelegate, DeleteItemDelegate {
    
    var items: [Item] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        view.backgroundColor = .bg
        titleContainers(view: self.view, name: "Maintenance")
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MaintenanceCell.self, forCellWithReuseIdentifier: "MaintenanceCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .bg
        view.addSubview(collectionView)
        setSubviews()
        makeConstraints()
        if !items.isEmpty {
            bgView.isHidden = true
        }
    }
    //MARK: - setSubviews

    func setSubviews() {
        let subviews = [bgView, createButton]
        for i in subviews {
            view.addSubview(i)
        }
    }
    //MARK: - makeConstraints
    func makeConstraints() {
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 55),
            createButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
        NSLayoutConstraint.activate([
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bgView.widthAnchor.constraint(equalToConstant: 230),
            bgView.heightAnchor.constraint(equalToConstant: 130)
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            collectionView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    //MARK: - createButtonTapped
    
    @objc private func createButtonTapped() {
        let create = CreateAircraftVC()
        let navController = UINavigationController(rootViewController: create)
        create.delegate = self
        present(navController, animated: true, completion: nil)
    }
    //MARK: - didCreateItem
    
    func didCreateItem(name: String, model: String, serialNumber: String, lastInsp: String, upcommingInsp: String) {
        let newItem = Item(name: name, model: model, serialNumber: serialNumber, lastInsp: lastInsp, upcommingInsp: upcommingInsp)
        if !items.contains(where: { $0.serialNumber == newItem.serialNumber }) {
            items.append(newItem)
            bgView.isHidden = true
            collectionView.reloadData()
        } else {
            print("Элемент с этим серийным номером уже существует")
        }
    }
    //MARK: - didUpdateItem
    
    func didUpdateItem(at index: Int, with name: String, model: String, serialNumber: String, lastInsp: String, upcommingInsp: String) {
        items[index].name = name
        items[index].model = model
        items[index].serialNumber = serialNumber
        items[index].lastInsp = lastInsp
        items[index].upcommingInsp = upcommingInsp
        collectionView.reloadData()
    }
    //MARK: - didDeleteItem

    func didDeleteItem(at index: IndexPath) {
        items.remove(at: index.row)
        collectionView.deleteItems(at: [index])
        if items.isEmpty {
            bgView.isHidden = false
        }
        collectionView.reloadData()
    }
}
//MARK: - UICollectionViewDataSource
extension MaintenanceVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items)
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MaintenanceCell", for: indexPath) as! MaintenanceCell
        cell.backgroundColor = .clear
        cell.namePlane.text = items[indexPath.row].name
        cell.modelPlane.text = items[indexPath.row].model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = ShowInfoVC()
        show.item = items[indexPath.row]
        show.index = indexPath.row
        show.delegate = self
        show.delegateDelete = self
        show.indexPath = indexPath
        let navController = UINavigationController(rootViewController: show)
        present(navController, animated: true, completion: nil)
    }
}
