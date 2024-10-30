import UIKit


class ShowAnalytics: UIViewController {
    
    let nameView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var dateContainer: UIView?
    var systemsContainer: UIView?
    var electronicContainer: UIView?
    var identifContainer: UIView?
    var notesContainer: UIView?
    
    var index: IndexPath?
    var item: AllItemsFlights?
    
    weak var deleteDelegate: DeleteAnalyticsItemDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        nameView.text = item?.name
        
        dateContainer = setShowContainerAnalytic(contName: "Date of verification", resultLabel: item?.date ?? "None", isBalance: false)
        let system = item?.system
        if system! {
            systemsContainer = setShowContainerAnalytic(contName: "Systems and components", resultLabel: "Okay", isBalance: true)
        } else { systemsContainer = setShowContainerAnalytic(contName: "Systems and components", resultLabel: "Violated", isBalance: true) }
        
        let electronic = item?.electronic
        if electronic! {
            electronicContainer = setShowContainerAnalytic(contName: "Electronics and avionics", resultLabel: "Okay", isBalance: true)
        } else { electronicContainer = setShowContainerAnalytic(contName: "Electronics and avionics", resultLabel: "Violated", isBalance: true) }

        
        let identif = item?.identification
        if identif! {
            identifContainer = setShowContainerAnalytic(contName: "Identification and \ncertification", resultLabel: "Okay", isBalance: true)
        } else { identifContainer = setShowContainerAnalytic(contName: "Identification and \ncertification", resultLabel: "Violated", isBalance: true) }
        
        notesContainer = setShowContainerAnalytic(contName: "Notes", resultLabel: item?.notes ?? "None", isBalance: false)
        
        setSubviews()
        makeConstraints()
    }
    func setSubviews() {
        let subviews = [nameView, deleteButton, dateContainer, systemsContainer, electronicContainer, identifContainer, notesContainer]
        for i in subviews {
            view.addSubview(i ?? bgView)
        }
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            deleteButton.heightAnchor.constraint(equalToConstant: 32),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            
            dateContainer!.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 25),
            dateContainer!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dateContainer!.heightAnchor.constraint(equalToConstant: 136),
            dateContainer!.widthAnchor.constraint(equalToConstant: 172),
            
            systemsContainer!.topAnchor.constraint(equalTo: dateContainer!.topAnchor),
            systemsContainer!.leadingAnchor.constraint(equalTo: dateContainer!.trailingAnchor, constant: 15),
            systemsContainer!.heightAnchor.constraint(equalToConstant: 136),
            systemsContainer!.widthAnchor.constraint(equalToConstant: 172),
            
            electronicContainer!.topAnchor.constraint(equalTo: dateContainer!.bottomAnchor, constant: 15),
            electronicContainer!.leadingAnchor.constraint(equalTo: dateContainer!.leadingAnchor),
            electronicContainer!.heightAnchor.constraint(equalToConstant: 136),
            electronicContainer!.widthAnchor.constraint(equalToConstant: 172),
            
            identifContainer!.topAnchor.constraint(equalTo: electronicContainer!.topAnchor),
            identifContainer!.leadingAnchor.constraint(equalTo: electronicContainer!.trailingAnchor, constant: 15),
            identifContainer!.heightAnchor.constraint(equalToConstant: 136),
            identifContainer!.widthAnchor.constraint(equalToConstant: 172),
            
            notesContainer!.topAnchor.constraint(equalTo: electronicContainer!.bottomAnchor, constant: 15),
            notesContainer!.leadingAnchor.constraint(equalTo: electronicContainer!.leadingAnchor),
            notesContainer!.trailingAnchor.constraint(equalTo: identifContainer!.trailingAnchor),
            notesContainer!.heightAnchor.constraint(equalToConstant: 136),
            
        ])
    }
    @objc private func deleteButtonTapped() {
        let alertController = UIAlertController(title: "Deletion", message: "Do you really want to delete it", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) {_ in
            if let indexPath = self.index {
                self.deleteDelegate?.didAnItem(at: indexPath)
                self.navigationController?.popViewController(animated: true)
            }
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
