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
        
        
        viewModel.fetchEverything(query: "bitcoin")
        viewModel.fetchTopHeadlines(country: "us")

                
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
    
}

final class MyTabbarController: UITabBarController {
    
}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.everything.count + 1 // Top Headlines ve Everything için toplam hücre sayısı
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            cell.configure(with: viewModel.topHeadlines) // Top Headlines verilerini gönder
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            let article = viewModel.everything[indexPath.row - 1] // -1 ile çünkü ilk hücrede Top Headlines bulunuyor
            cell.configure(with: article)
            return cell
        }
    }
}


extension HomePageVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
