import UIKit

class ShowMonitoringVC: UIViewController {
    
    let nameView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - edit/delete buttons
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .redTitle
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.imageView?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var weightContainer: UIView!
    var balanceContainer: UIView!
    var temperatureContainer: UIView!
    var airPressureContainer: UIView!
    var fuelConsumptionContainer: UIView!
    
    var monItem: ItemMonitoring?
    var monIndex: Int?
    var monIndexPath: IndexPath?
    weak var editMonDelegate: EditMonitoringVCDelegate?
    weak var deleteMonDelegate: DeleteMonitoringItemDelegate?
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        weightContainer = setShowContainer(nameImage: "dumbbell.fill", contName: "Weight",
                                           resultLabel: monItem?.weight ?? "None", isBalance: false)
        balanceContainer = setShowContainer(nameImage: "airplane", contName: "Balance",
                                            resultLabel: monItem?.balance ?? false ? "Okay" : "Violated", isBalance: true)
        temperatureContainer = setShowContainer(nameImage: "thermometer.medium", contName: "Engine temperature",
                                                resultLabel: monItem?.temperature ?? "None", isBalance: false)
        airPressureContainer = setShowContainer(nameImage: "wind", contName: "Air pressure",
                                                resultLabel: monItem?.airPressure ?? "None", isBalance: false)
        fuelConsumptionContainer = setShowContainer(nameImage: "fuelpump.exclamationmark.fill", contName: "Fuel consumption",
                                                    resultLabel: monItem?.fuelConsumption ?? "None", isBalance: false)
                
        setSubviews()
        makeConstraints()
        nameView.text = monItem?.name

    }
    //MARK: - setSubviews
    
    func setSubviews() {
        view.addSubview(nameView)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
        view.addSubview(weightContainer)
        view.addSubview(balanceContainer)
        view.addSubview(temperatureContainer)
        view.addSubview(airPressureContainer)
        view.addSubview(fuelConsumptionContainer)
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
            
            weightContainer.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 30),
            weightContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            weightContainer.heightAnchor.constraint(equalToConstant: 122),
            weightContainer.widthAnchor.constraint(equalToConstant: 172),
            
            balanceContainer.topAnchor.constraint(equalTo: weightContainer.topAnchor),
            balanceContainer.leadingAnchor.constraint(equalTo: weightContainer.trailingAnchor, constant: 15),
            balanceContainer.heightAnchor.constraint(equalToConstant: 122),
            balanceContainer.widthAnchor.constraint(equalToConstant: 172),
            
            temperatureContainer.topAnchor.constraint(equalTo: weightContainer.bottomAnchor, constant: 16),
            temperatureContainer.leadingAnchor.constraint(equalTo: weightContainer.leadingAnchor),
            temperatureContainer.heightAnchor.constraint(equalToConstant: 122),
            temperatureContainer.widthAnchor.constraint(equalToConstant: 172),
            
            airPressureContainer.topAnchor.constraint(equalTo: temperatureContainer.topAnchor),
            airPressureContainer.leadingAnchor.constraint(equalTo: temperatureContainer.trailingAnchor, constant: 16),
            airPressureContainer.heightAnchor.constraint(equalToConstant: 122),
            airPressureContainer.widthAnchor.constraint(equalToConstant: 172),
            
            fuelConsumptionContainer.topAnchor.constraint(equalTo: airPressureContainer.bottomAnchor, constant: 16),
            fuelConsumptionContainer.leadingAnchor.constraint(equalTo: temperatureContainer.leadingAnchor),
            fuelConsumptionContainer.trailingAnchor.constraint(equalTo: airPressureContainer.trailingAnchor),
            fuelConsumptionContainer.heightAnchor.constraint(equalToConstant: 122),
            
            ])
    }
    //MARK: - editButtonTapped
    @objc private func editButtonTapped() {
        let edit = EditMonitoringVC()
        edit.delegate = editMonDelegate
        edit.monItem = monItem
        edit.monIndex = monIndex
        let navCont = UINavigationController(rootViewController: edit)
        present(navCont, animated: true, completion: nil)
    }
    @objc private func deleteButtonTapped() {
        let alertController = UIAlertController(title: "Deletion", message: "Do you really want to delete it", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) {_ in
            if let indexPath = self.monIndexPath {
                self.deleteMonDelegate?.didDeleteMonItem(at: indexPath)
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
