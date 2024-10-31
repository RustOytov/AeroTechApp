import UIKit

class EditMonitoringVC: UIViewController {
    
    weak var delegate: EditMonitoringVCDelegate?
    var monItem: ItemMonitoring?
    var monIndex: Int?
    
    let nameView: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - set textFields
    var nameTextField: UITextField!
    var weightTextField: UITextField!
    var temperatureTextField: UITextField!
    var airPressureTextField: UITextField!
    var fuelConsumptionTextField: UITextField!
    
    //MARK: - balance
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let okBalanceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .bg
        button.setTitle("Okey", for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.greenBorder.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.4
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    let violatedBalanceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .bg
        button.setTitle("Violated", for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.redButton.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.4
        button.addTarget(self, action: #selector(violatedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - addButton

    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .redButton
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - viewDidLoad
    var balanceResult: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        
        nameTextField = setEditTextFields(placeholdertext: "Name", value: monItem?.name ?? "None")
        weightTextField = setEditTextFields(placeholdertext: "Weight", value: monItem?.weight ?? "None")
        temperatureTextField = setEditTextFields(placeholdertext: "Engine temperature", value: monItem?.temperature ?? "None")
        airPressureTextField = setEditTextFields(placeholdertext: "Air pressure", value: monItem?.airPressure ?? "None")
        fuelConsumptionTextField = setEditTextFields(placeholdertext: "Fuel consumption", value: monItem?.fuelConsumption ?? "None")
        if monItem?.balance ?? true {
            okBalanceButton.alpha = 1
        } else { violatedBalanceButton.alpha = 1}
        
        setSubviews()
        makeConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    //MARK: - setSubviews
    
    func setSubviews() {
        let subviews = [nameView, nameTextField,weightTextField, temperatureTextField, airPressureTextField,
                        fuelConsumptionTextField, balanceLabel, okBalanceButton, violatedBalanceButton, saveButton]
        for i in subviews {
            view.addSubview(i ?? nameView)
        }
    }
    
    //MARK: - makeConstraints

    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 25),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            weightTextField.heightAnchor.constraint(equalToConstant: 50),
            
            balanceLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 15),
            balanceLabel.leadingAnchor.constraint(equalTo: weightTextField.leadingAnchor),
            
            okBalanceButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 15),
            okBalanceButton.leadingAnchor.constraint(equalTo: balanceLabel.leadingAnchor),
            okBalanceButton.widthAnchor.constraint(equalToConstant: 140),
            okBalanceButton.heightAnchor.constraint(equalToConstant: 50),
            
            violatedBalanceButton.topAnchor.constraint(equalTo: okBalanceButton.topAnchor),
            violatedBalanceButton.leadingAnchor.constraint(equalTo: okBalanceButton.trailingAnchor, constant: 15),
            violatedBalanceButton.widthAnchor.constraint(equalToConstant: 140),
            violatedBalanceButton.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureTextField.topAnchor.constraint(equalTo: okBalanceButton.bottomAnchor, constant: 15),
            temperatureTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            temperatureTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            temperatureTextField.heightAnchor.constraint(equalToConstant: 50),
            
            airPressureTextField.topAnchor.constraint(equalTo: temperatureTextField.bottomAnchor, constant: 15),
            airPressureTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            airPressureTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            airPressureTextField.heightAnchor.constraint(equalToConstant: 50),
            
            fuelConsumptionTextField.topAnchor.constraint(equalTo: airPressureTextField.bottomAnchor, constant: 15),
            fuelConsumptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            fuelConsumptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            fuelConsumptionTextField.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.topAnchor.constraint(equalTo: fuelConsumptionTextField.bottomAnchor, constant: 15),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func dismissKeyboard() {
        nameTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        temperatureTextField.resignFirstResponder()
        airPressureTextField.resignFirstResponder()
        fuelConsumptionTextField.resignFirstResponder()
        }
    //MARK: - tappedButtons
    @objc private func okButtonTapped() {
        balanceResult = true
        okBalanceButton.alpha = 1
        violatedBalanceButton.alpha = 0.4
    }
    @objc private func violatedButtonTapped() {
        balanceResult = false
        violatedBalanceButton.alpha = 1
        okBalanceButton.alpha = 0.4
    }
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text,
              let weight = weightTextField.text,
              let temperature = temperatureTextField.text,
              let airPressure = airPressureTextField.text,
              let fuelConsumption = fuelConsumptionTextField.text else { print("add all parameters"); return }
        delegate?.didUpdateMonItem(at: self.monIndex!, with: name, weight: weight, balance: balanceResult,
                                   temperature: temperature, airPressure: airPressure, fuelConsumption: fuelConsumption)
        dismiss(animated: true, completion: nil)
    }
}
