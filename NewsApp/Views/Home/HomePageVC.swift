//
//  HomePageVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 6.09.2023.
//

import UIKit

class HomePageVC: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainBackView: UIView!
    @IBOutlet weak var backViewForSideMenu: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var leadingConstraintForSideMenu: NSLayoutConstraint!
    
    var sideMenuVC : SideMenuVC?
    let viewModel = HomeViewModel()
    
    private var isSideMenuShown:Bool = false
    
    var selectedCategory: Group = .general
    {
        didSet {
            viewModel.getNewsForCategory(selectedCategory)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "NEWS"
        
        self.backViewForSideMenu.isHidden = true
        self.mainBackView.layer.cornerRadius = 20
        self.mainBackView.clipsToBounds = true
        
        prepareTableView()
        viewModel.getNewsForCategory(selectedCategory)
        viewModel.getTopHeadlines()
                
        viewModel.request.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
            }
        }
       
    }
    
    func prepareTableView(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sideMenu")
        {
            if let controller = segue.destination as? SideMenuVC
            {
                self.sideMenuVC = controller
                self.sideMenuVC?.delegate = self
            }
        }
    }
    
    @IBAction func tappedOnBackView(_ sender: Any) {
        hideSideView()
        titleLabel.isHidden = false
    }
    
    @IBAction func showSideMenuBtnAct(_ sender: Any) {
        if isSideMenuShown {
            hideSideView()
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
            self.leadingConstraintForSideMenu.constant = 10
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.backViewForSideMenu.alpha = 0.75
                self.backViewForSideMenu.isHidden = false
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstraintForSideMenu.constant = 0
                    self.view.layoutIfNeeded()
                } completion: { (status) in
                    self.isSideMenuShown = true
                }
            }
        }
    }
    
    private func hideSideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.leadingConstraintForSideMenu.constant = 10
            self.backViewForSideMenu.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { (status) in
            UIView.animate(withDuration: 0.3, animations: {
                self.leadingConstraintForSideMenu.constant = -280
                self.view.layoutIfNeeded()
            }) { (status) in
                self.backViewForSideMenu.isHidden = true
                self.isSideMenuShown = false
            }
        }
    }
}

extension HomePageVC: SideMenuVCDelegate{
    func hideSideMenu() {
        self.hideSideView()
    }
    
    func didSelectCategory(_ category: Group) {
        selectedCategory = category
        hideSideView()
        titleLabel.isHidden = false
    }
}

//MARK: - Tab Bar
final class MyTabbarController: UITabBarController {
}

//MARK: - TableView
extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.request.everything.count + 1 // Top Headlines ve Everything için toplam hücre sayısı
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            cell.configure(with: viewModel.request.topHeadlines)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            let article = viewModel.request.everything[indexPath.row - 1] // -1 ile çünkü ilk hücrede Top Headlines bulunuyor
            cell.configure(with: article)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailPageVC", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailPageVC") as? DetailPageVC {
                detailVC.article = viewModel.request.everything[indexPath.row - 1]
                navigationController?.pushViewController(detailVC, animated: true)
            }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row{
        case 0:
            return 263
    
        default:
            return 150
        }
    }
}
