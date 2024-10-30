import UIKit

class TabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maintenance = MaintenanceVC()
        let monitoring = MonitoringVC()
        let flights = FlightsVC()
        let analytics = AnalyticsVC()
        let settings = SettingsVC()
        
        maintenance.tabBarItem = UITabBarItem(title: "Maintenance", image: UIImage(systemName: "airplane"), tag: 0)
        monitoring.tabBarItem = UITabBarItem(title: "Monitoring", image: UIImage(systemName: "gearshape.2"), tag: 1)
        flights.tabBarItem = UITabBarItem(title: "Flights", image: UIImage(systemName: "airplane.departure"), tag: 2)
        analytics.tabBarItem = UITabBarItem(title: "Analytics", image: UIImage(systemName: "doc.badge.gearshape.fill"), tag: 3)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .bg
        
        tabBar.standardAppearance = appearance
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .white
        tabBar.layer.borderWidth = 2
        tabBar.layer.borderColor = UIColor.redButton.cgColor
        tabBar.layer.cornerRadius = 60
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        viewControllers = [maintenance, monitoring, flights, analytics, settings]
        flights.analyticsDelegate = analytics
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 120
        tabBarFrame.size.width = 420
        tabBarFrame.origin.y = view.frame.height - tabBarFrame.size.height + 10
        tabBarFrame.origin.x = view.frame.width - tabBarFrame.size.width + 3
        tabBar.frame = tabBarFrame
    }
}
