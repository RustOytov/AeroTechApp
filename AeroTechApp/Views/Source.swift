import UIKit
//MARK: - titleContainers

func titleContainers(view: UIView, name: String) {
    let titleContainer = UIView()
    
    let text = UILabel()
    text.text = name
    text.textColor = .white
    text.font = .boldSystemFont(ofSize: 28)
    text.translatesAutoresizingMaskIntoConstraints = false
    titleContainer.addSubview(text)
    
    NSLayoutConstraint.activate([
        text.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -50),
        text.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor)
    ])
    
    titleContainer.backgroundColor = .redTitle
    titleContainer.layer.cornerRadius = 60
    titleContainer.layer.maskedCorners = [.layerMinXMaxYCorner]
    titleContainer.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleContainer)
    
    NSLayoutConstraint.activate([
        titleContainer.topAnchor.constraint(equalTo: view.topAnchor),
        titleContainer.widthAnchor.constraint(equalToConstant: view.frame.width),
        titleContainer.heightAnchor.constraint(equalToConstant: 115),
    ])
}
//MARK: - Maintenace struct-item

struct Item {
    var name: String
    var model: String
    var serialNumber: String
    var lastInsp: String
    var upcommingInsp: String
}
//MARK: - ItemMonitoring struct-item

struct ItemMonitoring {
    var name: String
    var weight: String
    var balance: Bool
    var temperature: String
    var airPressure: String
    var fuelConsumption: String
}

//MARK: - ItemFlights struct-item

struct ItemFlights {
    var name: String
    var checkDate: String
}

//MARK: - ItemCheckingFlights struct-item

struct ItemCheckingFlights {
    var systems: Bool
    var electronics: Bool
    var identification: Bool
}

//MARK: - AllItemsFlights struct-item

struct AllItemsFlights {
    var name: String
    var date: String
    var system: Bool
    var electronic: Bool
    var identification: Bool
    var notes: String
}
//MARK: - setTextFields

func setTextFields(placeholdertext: String) -> UITextField {
    let tf = UITextField()
    tf.layer.borderColor = UIColor.redButton.cgColor
    tf.layer.borderWidth = 2
    tf.layer.cornerRadius = 20
    tf.clipsToBounds = true
    let placeholderText = placeholdertext
    tf.backgroundColor = .bg
    let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
    tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    tf.textColor = .white
    tf.translatesAutoresizingMaskIntoConstraints = false
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
    tf.leftView = paddingView
    tf.leftViewMode = .always
    return tf
}
//MARK: - setEditTextFields

func setEditTextFields(placeholdertext: String, value: String) -> UITextField {
    let tf = UITextField()
    tf.layer.borderColor = UIColor.redButton.cgColor
    tf.layer.borderWidth = 2
    tf.layer.cornerRadius = 20
    tf.clipsToBounds = true
    let placeholderText = placeholdertext
    tf.backgroundColor = .bg
    let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
    tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    tf.text = value
    tf.textColor = .white
    tf.translatesAutoresizingMaskIntoConstraints = false
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
    tf.leftView = paddingView
    tf.leftViewMode = .always
    return tf
}
//MARK: - setShowContainer

func setShowContainer(nameImage: String, contName: String, resultLabel: String, isBalance: Bool) -> UIView {
    let container = UIView()
    container.backgroundColor = .bgCell
    container.layer.cornerRadius = 15
    container.clipsToBounds = true
    container.layer.borderColor = UIColor.grayBorder.cgColor
    container.layer.borderWidth = 2
    container.translatesAutoresizingMaskIntoConstraints = false
    
    let image = UIImageView()
    image.image = UIImage(systemName: "\(nameImage)")
    image.contentMode = .scaleAspectFill
    image.tintColor = .white
    image.alpha = 0.4
    image.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(image)
    
    let label = UILabel()
    label.text = contName
    label.textColor = .gray
    label.font = .systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(label)
    
    let secondLabel = UILabel()
    secondLabel.text = resultLabel
    if isBalance {
        if resultLabel == "Okay" {
            secondLabel.textColor = .greenBorder
        } else { secondLabel.textColor = .redButton }
    } else { secondLabel.textColor = .white }
    secondLabel.font = .boldSystemFont(ofSize: 20)
    secondLabel.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(secondLabel)
    
    NSLayoutConstraint.activate([
        image.topAnchor.constraint(equalTo: container.topAnchor, constant: 17),
        image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        image.heightAnchor.constraint(equalToConstant: 35),
        image.widthAnchor.constraint(equalToConstant: 35),
        
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
        
        secondLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
        secondLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor)
    ])
    
    return container
}

//MARK: - SetShowContainer for Analytic
func setShowContainerAnalytic(contName: String, resultLabel: String, isBalance: Bool) -> UIView {
    let container = UIView()
    container.backgroundColor = .bgCell
    container.layer.cornerRadius = 15
    container.clipsToBounds = true
    container.layer.borderColor = UIColor.grayBorder.cgColor
    container.layer.borderWidth = 2
    container.translatesAutoresizingMaskIntoConstraints = false
    
    let image = UIImageView()
    image.image = UIImage(systemName: "circlebadge")
    image.contentMode = .scaleAspectFill
    image.tintColor = .white
    image.alpha = 0.4
    image.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(image)
    
    let label = UILabel()
    label.text = contName
    label.numberOfLines = 0
    label.textColor = .gray
    label.font = .systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(label)
    
    let secondLabel = UILabel()
    secondLabel.text = resultLabel
    if isBalance {
        if resultLabel == "Okay" {
            secondLabel.textColor = .greenBorder
        } else { secondLabel.textColor = .redButton }
    } else { secondLabel.textColor = .white }
    secondLabel.font = .boldSystemFont(ofSize: 20)
    secondLabel.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(secondLabel)
    
    NSLayoutConstraint.activate([
        image.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
        image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        image.heightAnchor.constraint(equalToConstant: 35),
        image.widthAnchor.constraint(equalToConstant: 35),
        
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
        
        secondLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
        secondLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor)
    ])
    
    return container
}
//MARK: - containers for settings
func setContainerSettings(nameImage: String, textLabel: String) -> UIView {
    let container = UIView()
    container.backgroundColor = .bgCell
    container.clipsToBounds = true
    container.layer.cornerRadius = 20
    container.layer.borderWidth = 2
    container.layer.borderColor = UIColor.grayBorder.cgColor
    container.translatesAutoresizingMaskIntoConstraints = false
    
    let image = UIImageView()
    image.image = UIImage(systemName: nameImage)
    image.tintColor = .white
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(image)
    
    let label = UILabel()
    label.text = textLabel
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(label)
    
    let threeDot = UIImageView()
    threeDot.image = UIImage(systemName: "ellipsis")
    threeDot.tintColor = .white
    threeDot.alpha = 0.4
    threeDot.contentMode = .scaleAspectFill
    threeDot.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(threeDot)
    
    NSLayoutConstraint.activate([
        image.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 17),
        image.widthAnchor.constraint(equalToConstant: 38),
        image.heightAnchor.constraint(equalToConstant: 31),
        
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 30),
        label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -45),
        
        threeDot.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        threeDot.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: -41),
        threeDot.heightAnchor.constraint(equalToConstant: 24),
        threeDot.widthAnchor.constraint(equalToConstant: 24)
    ])
    return container
}

let namePlane: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()
//MARK: - setFlightsOkButton

func setFlightsOkButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .bg
    button.setTitle("Okey", for: .normal)
    button.layer.cornerRadius = 20
    button.layer.borderColor = UIColor.greenBorder.cgColor
    button.layer.borderWidth = 2
    button.translatesAutoresizingMaskIntoConstraints = false
    button.alpha = 0.4
    return button
}
//MARK: - setFlightsViolatedButton

func setFlightsViolatedButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .bg
    button.setTitle("Violated", for: .normal)
    button.layer.cornerRadius = 20
    button.layer.borderColor = UIColor.redButton.cgColor
    button.layer.borderWidth = 2
    button.translatesAutoresizingMaskIntoConstraints = false
    button.alpha = 0.4
    return button
}
