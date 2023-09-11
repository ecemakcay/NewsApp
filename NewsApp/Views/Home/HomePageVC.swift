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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSearchBar()
        prepareTableView()
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

extension HomePageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           switch indexPath.row {
           case 0:
               let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
               
               return cell
               
           default:
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
              
               return cell
           }
    }
    
    
}

extension HomePageVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
