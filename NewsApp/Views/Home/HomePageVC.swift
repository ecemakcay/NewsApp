//
//  HomePageVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 6.09.2023.
//

import UIKit

class HomePageVC: UIViewController{
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeSearchBar: UISearchBar!
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSearchBar()
        prepareTableView()
        configureSearchBarColors()
        
        
        viewModel.fetchEverything(query: "general")
        viewModel.fetchTopHeadlines()

                
        // Verilerin güncellenmesini dinlemek için
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
            }
        }
    }
    
    func prepareSearchBar(){
        homeSearchBar.delegate = self
    }
    
    func prepareTableView(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    func configureSearchBarColors() {
        if let searchTextField = homeSearchBar?.searchTextField {
            searchTextField.textColor = .white
            searchTextField.tintColor = .white
            
            if let leftView = searchTextField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor(named: "color5")
            }
            searchTextField.backgroundColor = UIColor(named: "color3")
        }
    }
    
}

//MARK: Tab Bar
final class MyTabbarController: UITabBarController {
  
}

//MARK: TableView
extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.everything.count + 1 // Top Headlines ve Everything için toplam hücre sayısı
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            cell.configure(with: viewModel.topHeadlines)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            let article = viewModel.everything[indexPath.row - 1] // -1 ile çünkü ilk hücrede Top Headlines bulunuyor
            cell.configure(with: article)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailPageVC", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailPageVC") as? DetailPageVC {
                detailVC.article = viewModel.everything[indexPath.row - 1]
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
//MARK: Search Bar
extension HomePageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchEverything(query: searchText)
    }
}
