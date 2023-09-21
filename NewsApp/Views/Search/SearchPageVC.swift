//
//  SearchPageVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 19.09.2023.
//

import UIKit

class SearchPageVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
        prepareSearchBar()
        prepareTableView()
        configureSearchBarColors()
    
        topView.layer.cornerRadius = 20
        
        viewModel.request.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }

    }
    
    
    func prepareSearchBar(){
        searchBar.delegate = self
    }
    
    func prepareTableView(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func configureSearchBarColors() {
        if let searchTextField = searchBar?.searchTextField {
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

//MARK: - SearchBar
extension SearchPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSearch(query: searchText)
    }
}

//MARK: - TableView
extension SearchPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.request.everything.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            let article = viewModel.request.everything[indexPath.row ]
            cell.configure(with: article)
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailPageVC", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailPageVC") as? DetailPageVC {
                detailVC.article = viewModel.request.everything[indexPath.row]
                navigationController?.pushViewController(detailVC, animated: true)
            }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 150
    }
}
