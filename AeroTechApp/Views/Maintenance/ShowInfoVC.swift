import UIKit

//MARK: - ShowInfoVC

class ShowInfoVC: UIViewController {
    weak var delegate: EditVCDelegate?
    var item: Item?
    var index: Int?
    weak var delegateDelete: DeleteItemDelegate?
    var indexPath: IndexPath?
    
    let nameView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - edit/delete button
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .redTitle
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.imageView?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .redTitle
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.imageView?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - planeTakeOff
    let planeTakeOff: UIImageView = {
        let image = UIImageView()
        image.image = .takeoff
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let justLine: UIView = {
        let line = UIView()
        line.backgroundColor = .redButton
        line.contentMode = .scaleAspectFit
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    //MARK: - modelContainer
    let modelContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .bgCell
        container.layer.cornerRadius = 20
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.grayBorder.cgColor
        
        let circle = UIImageView()
        circle.image = UIImage(systemName: "circlebadge")
        circle.contentMode = .scaleAspectFill
        circle.tintColor = .white
        circle.alpha = 0.4
        circle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(circle)
        
        let titleContainer = UILabel()
        titleContainer.text = "Model"
        titleContainer.textColor = .white
        titleContainer.alpha = 0.4
        titleContainer.font = .systemFont(ofSize: 15)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleContainer)
        
        let labelContainer = UILabel()
        labelContainer.textColor = .white
        labelContainer.font = .boldSystemFont(ofSize: 18)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(labelContainer)
        
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            circle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            circle.heightAnchor.constraint(equalToConstant: 25),
            circle.widthAnchor.constraint(equalToConstant: 25),
            
            titleContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 17),
            titleContainer.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15),
            
            labelContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 6),
            labelContainer.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    //MARK: - serialNumberContainer
    let serialNumberContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .bgCell
        container.layer.cornerRadius = 20
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.grayBorder.cgColor
        
        let circle = UIImageView()
        circle.image = UIImage(systemName: "circlebadge")
        circle.contentMode = .scaleAspectFill
        circle.tintColor = .white
        circle.alpha = 0.4
        circle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(circle)
        
        let titleContainer = UILabel()
        titleContainer.text = "Serial number"
        titleContainer.textColor = .white
        titleContainer.alpha = 0.4
        titleContainer.font = .systemFont(ofSize: 15)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleContainer)
        
        let labelContainer = UILabel()
        labelContainer.textColor = .white
        labelContainer.font = .boldSystemFont(ofSize: 18)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(labelContainer)
        
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            circle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            circle.heightAnchor.constraint(equalToConstant: 25),
            circle.widthAnchor.constraint(equalToConstant: 25),
            
            titleContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 17),
            titleContainer.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15),
            
            labelContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 6),
            labelContainer.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    //MARK: - LastInspectionContainer
    let lastInspectionContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .bgCell
        container.layer.cornerRadius = 20
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.grayBorder.cgColor
        
        let circle = UIImageView()
        circle.image = UIImage(systemName: "circlebadge")
        circle.contentMode = .scaleAspectFill
        circle.tintColor = .white
        circle.alpha = 0.4
        circle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(circle)
        
        let titleContainer = UILabel()
        titleContainer.text = "Last inspection"
        titleContainer.textColor = .white
        titleContainer.alpha = 0.4
        titleContainer.font = .systemFont(ofSize: 15)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleContainer)
        
        let labelContainer = UILabel()
        labelContainer.textColor = .white
        labelContainer.font = .boldSystemFont(ofSize: 18)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(labelContainer)
        
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            circle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            circle.heightAnchor.constraint(equalToConstant: 25),
            circle.widthAnchor.constraint(equalToConstant: 25),
            
            titleContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 17),
            titleContainer.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15),
            
            labelContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 6),
            labelContainer.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    //MARK: - upcomingInspectionContainer
    let upcomingInspectionContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .bgCell
        container.layer.cornerRadius = 20
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.grayBorder.cgColor
        
        let circle = UIImageView()
        circle.image = UIImage(systemName: "circlebadge")
        circle.contentMode = .scaleAspectFill
        circle.tintColor = .white
        circle.alpha = 0.4
        circle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(circle)
        
        let titleContainer = UILabel()
        titleContainer.text = "Upcoming inspection"
        titleContainer.textColor = .white
        titleContainer.alpha = 0.4
        titleContainer.font = .systemFont(ofSize: 15)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleContainer)
        
        let labelContainer = UILabel()
        labelContainer.textColor = .white
        labelContainer.font = .boldSystemFont(ofSize: 18)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(labelContainer)
        
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            circle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            circle.heightAnchor.constraint(equalToConstant: 25),
            circle.widthAnchor.constraint(equalToConstant: 25),
            
            titleContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 17),
            titleContainer.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15),
            titleContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            
            labelContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 6),
            labelContainer.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        setSubviews()
        makeConstraints()
        nameView.text = item?.name ?? ""
        editButton.addTarget(self, action: #selector(editButtonTappped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTappped), for: .touchUpInside)
        modelContainer.subviews.compactMap { $0 as? UILabel }.first { $0.font == .boldSystemFont(ofSize: 18) }?.text = item?.model
        serialNumberContainer.subviews.compactMap { $0 as? UILabel }.first { $0.font == .boldSystemFont(ofSize: 18) }?.text = item?.serialNumber
        lastInspectionContainer.subviews.compactMap { $0 as? UILabel }.first { $0.font == .boldSystemFont(ofSize: 18) }?.text = item?.lastInsp
        upcomingInspectionContainer.subviews.compactMap { $0 as? UILabel }.first { $0.font == .boldSystemFont(ofSize: 18) }?.text = item?.upcommingInsp
    }
    //MARK: - setSubviews

    func setSubviews() {
        view.addSubview(nameView)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
        view.addSubview(planeTakeOff)
        view.addSubview(justLine)
        view.addSubview(modelContainer)
        view.addSubview(serialNumberContainer)
        view.addSubview(lastInspectionContainer)
        view.addSubview(upcomingInspectionContainer)
    }
    //MARK: - makeConstraints
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            deleteButton.leadingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: 10),
            deleteButton.heightAnchor.constraint(equalToConstant: 32),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            
            planeTakeOff.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            planeTakeOff.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            planeTakeOff.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            planeTakeOff.heightAnchor.constraint(equalToConstant: 215),
            
            justLine.topAnchor.constraint(equalTo: planeTakeOff.bottomAnchor, constant: 35),
            justLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            justLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            justLine.heightAnchor.constraint(equalToConstant: 2),
            
            modelContainer.topAnchor.constraint(equalTo: justLine.bottomAnchor, constant: 30),
            modelContainer.leadingAnchor.constraint(equalTo: justLine.leadingAnchor),
            modelContainer.widthAnchor.constraint(equalToConstant: 175),
            modelContainer.heightAnchor.constraint(equalToConstant: 75),
            
            serialNumberContainer.topAnchor.constraint(equalTo: modelContainer.topAnchor),
            serialNumberContainer.leadingAnchor.constraint(equalTo: modelContainer.trailingAnchor, constant: 16),
            serialNumberContainer.widthAnchor.constraint(equalToConstant: 175),
            serialNumberContainer.heightAnchor.constraint(equalToConstant: 75),
            
            lastInspectionContainer.topAnchor.constraint(equalTo: modelContainer.bottomAnchor, constant: 16),
            lastInspectionContainer.leadingAnchor.constraint(equalTo: modelContainer.leadingAnchor),
            lastInspectionContainer.widthAnchor.constraint(equalToConstant: 175),
            lastInspectionContainer.heightAnchor.constraint(equalToConstant: 75),
            
            upcomingInspectionContainer.topAnchor.constraint(equalTo: lastInspectionContainer.topAnchor),
            upcomingInspectionContainer.leadingAnchor.constraint(equalTo: lastInspectionContainer.trailingAnchor, constant: 16),
            upcomingInspectionContainer.widthAnchor.constraint(equalToConstant: 175),
            upcomingInspectionContainer.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
    //MARK: - editButtonTappped
    @objc private func editButtonTappped() {
        let edit = EditVC()
        edit.item = item
        edit.index = index
        edit.delegate = delegate
        let navController = UINavigationController(rootViewController: edit)
        present(navController, animated: true, completion: nil)
    }
    //MARK: - deleteButtonTappped
    @objc private func deleteButtonTappped() {
        let alertController = UIAlertController(title: "Delition", message: "Do you really want to delete it?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) {_ in
            if let indexPath = self.indexPath {
                self.delegateDelete?.didDeleteItem(at: indexPath)
                self.navigationController?.popViewController(animated: true)
            }
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
