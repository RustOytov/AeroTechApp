protocol AddFlightsVCDelegate: AnyObject {
    func addFlights(with name: String, date: String, system: Bool, electronic: Bool, identification: Bool, notes: String)
}
import UIKit

class AddFlightsVC: UIViewController {
    
    let nameView: UILabel = {
        let label = UILabel()
        label.text = "New nearest flights"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField = {setTextFields(placeholdertext: "Name")}()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.text = "Check before"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkData: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .bg
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.layer.cornerRadius = 10
        datePicker.layer.borderColor = UIColor.redButton.cgColor
        datePicker.layer.borderWidth = 2
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: +100, to: Date())
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .redButton
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate: AddFlightsVCDelegate?
    var selectedCheckData: Date?
    var selectedCheckDataStr: String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .bg
        setSubviews()
        makeConstraints()
        checkData.addTarget(self, action: #selector(changedDate), for: .valueChanged)
        
    }
    func setSubviews() {
        view.addSubview(nameView)
        view.addSubview(nameTextField)
        view.addSubview(dataLabel)
        view.addSubview(checkData)
        view.addSubview(addButton)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 25),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            dataLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            dataLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            
            checkData.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 15),
            checkData.leadingAnchor.constraint(equalTo: dataLabel.leadingAnchor),
            checkData.heightAnchor.constraint(equalToConstant: 45),
            checkData.widthAnchor.constraint(equalToConstant: 125),
            
            addButton.topAnchor.constraint(equalTo: checkData.bottomAnchor, constant: 15),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            addButton.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    @objc private func changedDate(_ sender: UIDatePicker) {
        selectedCheckData = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        selectedCheckDataStr = dateFormatter.string(from: selectedCheckData!)
    }
    @objc private func addButtonTapped() {
        delegate?.addFlights(with: nameTextField.text!, date: selectedCheckDataStr, system: false, electronic: false, identification: false, notes: "")
        dismiss(animated: true, completion: nil)
    }
}
