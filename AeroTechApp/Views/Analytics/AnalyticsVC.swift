import UIKit
protocol DeleteAnalyticsItemDelegate: AnyObject {
    func didAnItem(at index: IndexPath)
}
class AnalyticsVC: UIViewController, UICollectionViewDelegateFlowLayout, AddAnalyticsDelegate, DeleteAnalyticsItemDelegate {
    
    let bgView: UIView = {
        let container = UIView()
        
        let image = UIImageView()
        image.image = .reports
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(image)
        
        let mainLabel = UILabel()
        mainLabel.text = "Reports"
        mainLabel.textColor = .white
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainLabel)
        
        let secondLabel = UILabel()
        secondLabel.numberOfLines = 0
        secondLabel.text = "Your reports will be displayed \n                      here"
        secondLabel.textColor = .white
        secondLabel.alpha = 0.4
        secondLabel.font = .systemFont(ofSize: 16)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 13),
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 63),
            
            mainLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 13),
            mainLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 6),
            secondLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    var items: [AllItemsFlights] = []
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        view.backgroundColor = .bg
        titleContainers(view: self.view, name: "Analytics")
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AnalyticsCell.self, forCellWithReuseIdentifier: "AnalyticsCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .bg
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        setSubviews()
        makeConstraints()
    }
    //MARK: - setSubviews
    func setSubviews() {
        let subviews = [bgView]
        for i in subviews {
            view.addSubview(i)
        }
    }
    //MARK: - makeConstraints
    func makeConstraints() {
        NSLayoutConstraint.activate([
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bgView.widthAnchor.constraint(equalToConstant: 230),
            bgView.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
    func AddAnalytics(with name: String, date: String, system: Bool, electronic: Bool, identification: Bool, notes: String) {
        items.append(AllItemsFlights(name: name, date: date, system: system, electronic: electronic, identification: identification, notes: notes))
        if collectionView != nil {
            collectionView.reloadData()
        } else {
            print("collectionView is nil")
        }
        if !items.isEmpty {
            bgView.isHidden = true
        }
        print(items)
    }
    func didAnItem(at index: IndexPath) {
        items.remove(at: index.row)
        collectionView.deleteItems(at: [index])
        if items.isEmpty {
            bgView.isHidden = false
        }
        collectionView.reloadData()
    }
}

extension AnalyticsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalyticsCell", for: indexPath) as! AnalyticsCell
        cell.nameLabel.text = items[indexPath.row].name
        cell.secondDateLabel.text = "Report from the \(items[indexPath.row].date)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = ShowAnalytics()
        let navCon = UINavigationController(rootViewController: show)
        show.index = indexPath
        show.item = items[indexPath.row]
        show.deleteDelegate = self
        present(navCon, animated: true, completion: nil)
    }
}
