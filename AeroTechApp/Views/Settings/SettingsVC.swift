import UIKit

class SettingsVC: UIViewController {
    
    let shareContainer = setContainerSettings(nameImage: "square.and.arrow.up.fill", textLabel: "Share app")
    let policyContainer = setContainerSettings(nameImage: "list.bullet.clipboard.fill", textLabel: "Usage Policy")
    let rateContainer = setContainerSettings(nameImage: "star.fill", textLabel: "Rate app")
    
    override func viewDidLoad() {
        view.backgroundColor = .bg
        titleContainers(view: self.view, name: "Settings")
        setSubviews()
        makeConstraints()
    }
    
    func setSubviews() {
        let subviews = [shareContainer, policyContainer, rateContainer]
        for i in subviews {
            view.addSubview(i)
        }
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            shareContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            shareContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            shareContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            shareContainer.heightAnchor.constraint(equalToConstant: 70),
            
            policyContainer.topAnchor.constraint(equalTo: shareContainer.bottomAnchor, constant: 20),
            policyContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            policyContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            policyContainer.heightAnchor.constraint(equalToConstant: 70),
            
            rateContainer.topAnchor.constraint(equalTo: policyContainer.bottomAnchor, constant: 20),
            rateContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            rateContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            rateContainer.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
