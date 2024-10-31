import UIKit

protocol DeleteCheckingFlightsVCDelegate: AnyObject  {
    func didDeleteCheckingFlights(with name: String, date: String, system: Bool, electronic: Bool, identification: Bool, notes: String, indexForDelete: IndexPath)
}
protocol AddAnalyticsDelegate: AnyObject {
    func AddAnalytics(with name: String, date: String, system: Bool, electronic: Bool, identification: Bool, notes: String)
}
class CheckingFlightsVC: UIViewController {
    
    var item: AllItemsFlights?
    var indexPathItem: IndexPath?
    weak var delegate: DeleteCheckingFlightsVCDelegate?
    weak var anDelegate: AddAnalyticsDelegate?
    
    let nameView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of verification"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateContainer: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.borderWidth = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - system
    
    let systemLabel: UILabel = {
        let label = UILabel()
        label.text = "Systems and components"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var systemOkButton = setFlightsOkButton()
    var systemViolatedButton = setFlightsViolatedButton()
    var systemResult: Bool = false
    
    //MARK: - electronics
    let electronicsLabel: UILabel = {
        let label = UILabel()
        label.text = "Electronics and avionics"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var electronicsOkButton = setFlightsOkButton()
    var electronicsViolatedButton = setFlightsViolatedButton()
    var electronicsResult: Bool = false
    
    //MARK: - identification
    let identificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Identification and certification"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var identificationOkButton = setFlightsOkButton()
    var identificationViolatedButton = setFlightsViolatedButton()
    var identificationResult: Bool = false
    
    //MARK: - texfield
    let notesField = setEditTextFields(placeholdertext: "Notes", value: "")
    
    let makeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .redButton
        button.setTitle("Make a report", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(makeButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        setSibviews()
        makeConstraints()
        nameView.text = item?.name
        dateContainer.text = item?.date
        
        systemOkButton.addTarget(self, action: #selector(systemOkButtonTapped), for: .touchUpInside)
        systemViolatedButton.addTarget(self, action: #selector(systemViolatedButtonTapped), for: .touchUpInside)
        
        electronicsOkButton.addTarget(self, action: #selector(electronicsOkButtonTapped), for: .touchUpInside)
        electronicsViolatedButton.addTarget(self, action: #selector(electronicsViolatedButtonTapped), for: .touchUpInside)
        
        identificationOkButton.addTarget(self, action: #selector(identificationOkButtonTapped), for: .touchUpInside)
        identificationViolatedButton.addTarget(self, action: #selector(identificationViolatedButtonTapped), for: .touchUpInside)
        
        notesField.layer.borderColor = UIColor.grayBorder.cgColor
//        print(indexPathItem!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - setSibviews

    func setSibviews() {
        let subviews = [nameView, dateLabel, dateContainer,
                        systemLabel, systemOkButton, systemViolatedButton,
                        electronicsLabel, electronicsOkButton, electronicsViolatedButton,
                        identificationLabel,identificationOkButton, identificationViolatedButton,
                        notesField, makeButton]
        for i in subviews {
            view.addSubview(i)
        }
        
    }
    
    //MARK: - makeConstraints

    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 31),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            dateContainer.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            dateContainer.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            dateContainer.heightAnchor.constraint(equalToConstant: 45),
            dateContainer.widthAnchor.constraint(equalToConstant: 130),
            
            systemLabel.topAnchor.constraint(equalTo: dateContainer.bottomAnchor, constant: 15),
            systemLabel.leadingAnchor.constraint(equalTo: dateContainer.leadingAnchor),
            
            systemOkButton.topAnchor.constraint(equalTo: systemLabel.bottomAnchor, constant: 15),
            systemOkButton.leadingAnchor.constraint(equalTo: systemLabel.leadingAnchor),
            systemOkButton.widthAnchor.constraint(equalToConstant: 140),
            systemOkButton.heightAnchor.constraint(equalToConstant: 50),
            
            systemViolatedButton.topAnchor.constraint(equalTo: systemOkButton.topAnchor),
            systemViolatedButton.leadingAnchor.constraint(equalTo: systemOkButton.trailingAnchor, constant: 15),
            systemViolatedButton.widthAnchor.constraint(equalToConstant: 140),
            systemViolatedButton.heightAnchor.constraint(equalToConstant: 50),
            
            electronicsLabel.topAnchor.constraint(equalTo: systemOkButton.bottomAnchor, constant: 15),
            electronicsLabel.leadingAnchor.constraint(equalTo: systemOkButton.leadingAnchor),
            
            electronicsOkButton.topAnchor.constraint(equalTo: electronicsLabel.bottomAnchor, constant: 15),
            electronicsOkButton.leadingAnchor.constraint(equalTo: electronicsLabel.leadingAnchor),
            electronicsOkButton.widthAnchor.constraint(equalToConstant: 140),
            electronicsOkButton.heightAnchor.constraint(equalToConstant: 50),
            
            electronicsViolatedButton.topAnchor.constraint(equalTo: electronicsOkButton.topAnchor),
            electronicsViolatedButton.leadingAnchor.constraint(equalTo: electronicsOkButton.trailingAnchor, constant: 15),
            electronicsViolatedButton.widthAnchor.constraint(equalToConstant: 140),
            electronicsViolatedButton.heightAnchor.constraint(equalToConstant: 50),
            
            identificationLabel.topAnchor.constraint(equalTo: electronicsOkButton.bottomAnchor, constant: 15),
            identificationLabel.leadingAnchor.constraint(equalTo: electronicsOkButton.leadingAnchor),
            
            identificationOkButton.topAnchor.constraint(equalTo: identificationLabel.bottomAnchor, constant: 15),
            identificationOkButton.leadingAnchor.constraint(equalTo: identificationLabel.leadingAnchor),
            identificationOkButton.widthAnchor.constraint(equalToConstant: 140),
            identificationOkButton.heightAnchor.constraint(equalToConstant: 50),
            
            identificationViolatedButton.topAnchor.constraint(equalTo: identificationOkButton.topAnchor),
            identificationViolatedButton.leadingAnchor.constraint(equalTo: identificationOkButton.trailingAnchor, constant: 15),
            identificationViolatedButton.widthAnchor.constraint(equalToConstant: 140),
            identificationViolatedButton.heightAnchor.constraint(equalToConstant: 50),
            
            notesField.topAnchor.constraint(equalTo: identificationOkButton.bottomAnchor, constant: 15),
            notesField.leadingAnchor.constraint(equalTo: identificationOkButton.leadingAnchor),
            notesField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            notesField.heightAnchor.constraint(equalToConstant: 50),
            
            makeButton.topAnchor.constraint(equalTo: notesField.bottomAnchor, constant: 15),
            makeButton.leadingAnchor.constraint(equalTo: notesField.leadingAnchor),
            makeButton.trailingAnchor.constraint(equalTo: notesField.trailingAnchor),
            makeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    //system
    @objc private func systemOkButtonTapped() {
        systemResult = true
        systemOkButton.alpha = 1
        systemViolatedButton.alpha = 0.4
    }
    @objc private func systemViolatedButtonTapped() {
        systemResult = false
        systemViolatedButton.alpha = 1
        systemOkButton.alpha = 0.4
    }
    //electronic
    @objc private func electronicsOkButtonTapped() {
        electronicsResult = true
        electronicsOkButton.alpha = 1
        electronicsViolatedButton.alpha = 0.4
    }
    @objc private func electronicsViolatedButtonTapped() {
        electronicsResult = false
        electronicsViolatedButton.alpha = 1
        electronicsOkButton.alpha = 0.4
    }
    
    // identification
    @objc private func identificationOkButtonTapped() {
        identificationResult = true
        identificationOkButton.alpha = 1
        identificationViolatedButton.alpha = 0.4
    }
    @objc private func identificationViolatedButtonTapped() {
        identificationResult = false
        identificationViolatedButton.alpha = 1
        identificationOkButton.alpha = 0.4
    }
    
    //for hide keyboard
    @objc func dismissKeyboard() {
        notesField.resignFirstResponder()
        }
    
    @objc private func makeButtonTapped() {
        delegate?.didDeleteCheckingFlights(with: item!.name, date: item!.date,
                                     system: systemResult, electronic: electronicsResult,
                                     identification: identificationResult, notes: notesField.text!, indexForDelete: indexPathItem!)
        
        anDelegate?.AddAnalytics(with: item!.name, date: item!.date,
                                 system: systemResult, electronic: electronicsResult,
                                 identification: identificationResult, notes: notesField.text!)
        dismiss(animated: true, completion: nil)
    }
}
