import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCells()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: model.self).reuseId, for: indexPath)
        model.configure(cell: cell)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewModel = TitleButtonViewModel(title: "Main Menu", buttonImage: UIImage(named: "tune")!) {
            self.navigateToSettings()
        }
        let headerView = TitleButtonView()
        headerView.configure(with: headerViewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Navigation Helpers & HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    
    func cellTapped(type: HomeCellType) {
        let listViewController = ListViewController.instantiate()
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func navigateToSettings() {
        let settingsViewController = SettingsViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - TableView Helpers

extension HomeViewController {
    
    private func registerTableViewCells() {
        for model in viewModel.data {
            model.register(in: tableView)
        }
    }
}
