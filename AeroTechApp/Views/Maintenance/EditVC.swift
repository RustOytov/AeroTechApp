import UIKit

class EditVC: UIViewController {
    
    let nameView: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - TextFields
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.redButton.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 20
        tf.clipsToBounds = true
        let placeholderText = "Name"
        tf.backgroundColor = .bg
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    let modelTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.redButton.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 20
        tf.clipsToBounds = true
        let placeholderText = "Model"
        tf.backgroundColor = .bg
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    let serialNumberTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.redButton.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 20
        tf.clipsToBounds = true
        let placeholderText = "Serial number"
        tf.backgroundColor = .bg
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    //MARK: - inspections
    let lastInspection: UILabel = {
        let label = UILabel()
        label.text = "Last inspection"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let upcomingInspection: UILabel = {
        let label = UILabel()
        label.text = "Upcoming inspection"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - UIDatePickers
    let lastInspPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .bg
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.layer.cornerRadius = 10
        datePicker.layer.borderColor = UIColor.redButton.cgColor
        datePicker.layer.borderWidth = 2
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        datePicker.maximumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    let upcomingInspPicker: UIDatePicker = {
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
    //MARK: - createButton
    let buttonSave: UIButton = {
        let button = UIButton()
        button.backgroundColor = .redButton
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonEditTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: EditVCDelegate?
    var item: Item?
    var index: Int?
    
    var selectedLastInsp: Date?
    var selectedLastInspStr: String = ""
    var selectedUpcomInsp: Date?
    var selectedUpcomInspStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        setSubviews()
        makeConstraints()
        
        nameTextField.text = item?.name
        modelTextField.text = item?.model
        serialNumberTextField.text = item?.serialNumber
        lastInspPicker.addTarget(self, action: #selector(changedDate), for: .valueChanged)
        upcomingInspPicker.addTarget(self, action: #selector(changedDateTwo), for: .valueChanged)
    }
    //MARK: - setSubviews

    func setSubviews() {
        nameTextField.borderStyle = .roundedRect
        let subviews = [nameView, nameTextField, modelTextField, serialNumberTextField,
                        lastInspection, upcomingInspection, lastInspPicker, upcomingInspPicker, buttonSave]
        for i in subviews {
            view.addSubview(i)
        }
    }
    //MARK: - makeConstraints
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 25),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.widthAnchor.constraint(equalToConstant: 360),
            
            modelTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            modelTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modelTextField.heightAnchor.constraint(equalToConstant: 50),
            modelTextField.widthAnchor.constraint(equalToConstant: 360),
            
            serialNumberTextField.topAnchor.constraint(equalTo: modelTextField.bottomAnchor, constant: 15),
            serialNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            serialNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            serialNumberTextField.widthAnchor.constraint(equalToConstant: 360),
        ])
        NSLayoutConstraint.activate([
            lastInspection.topAnchor.constraint(equalTo: serialNumberTextField.bottomAnchor, constant: 15),
            lastInspection.leadingAnchor.constraint(equalTo: serialNumberTextField.leadingAnchor),
            
            upcomingInspection.topAnchor.constraint(equalTo: lastInspection.topAnchor),
            upcomingInspection.leadingAnchor.constraint(equalTo: lastInspection.trailingAnchor, constant: 75)
        ])
        NSLayoutConstraint.activate([
            lastInspPicker.topAnchor.constraint(equalTo: lastInspection.bottomAnchor, constant: 15),
            lastInspPicker.leadingAnchor.constraint(equalTo: lastInspection.leadingAnchor),
            lastInspPicker.heightAnchor.constraint(equalToConstant: 45),
            lastInspPicker.widthAnchor.constraint(equalToConstant: 125),
            
            upcomingInspPicker.topAnchor.constraint(equalTo: lastInspPicker.topAnchor),
            upcomingInspPicker.leadingAnchor.constraint(equalTo: upcomingInspection.leadingAnchor),
            upcomingInspPicker.heightAnchor.constraint(equalToConstant: 45),
            upcomingInspPicker.widthAnchor.constraint(equalToConstant: 125),
        ])
        NSLayoutConstraint.activate([
            buttonSave.topAnchor.constraint(equalTo: lastInspPicker.bottomAnchor, constant: 15),
            buttonSave.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSave.heightAnchor.constraint(equalToConstant: 55),
            buttonSave.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
    }
    //MARK: - changedDate
    
    @objc private func changedDate(_ sender: UIDatePicker) {
        selectedLastInsp = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        selectedLastInspStr = dateFormatter.string(from: selectedLastInsp!)
    }
    //MARK: - changedDateTwo
    
    @objc private func changedDateTwo(_ sender: UIDatePicker) {
        selectedUpcomInsp = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        selectedUpcomInspStr = dateFormatter.string(from: selectedUpcomInsp!)
    }
    //MARK: - buttonEditTapped
    
    @objc private func buttonEditTapped() {
        guard let index = index,
              let name = nameTextField.text,
              let model = modelTextField.text,
              let serialNumber = serialNumberTextField.text,
              !selectedLastInspStr.isEmpty,
              !selectedUpcomInspStr.isEmpty else { return }
        delegate?.didUpdateItem(at: index, with: name, model: model, serialNumber: serialNumber, lastInsp: selectedLastInspStr, upcommingInsp: selectedUpcomInspStr)
        dismiss(animated: true, completion: nil)
    }
}
