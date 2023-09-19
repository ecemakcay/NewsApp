//
//  SideMenuVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 19.09.2023.
//

import UIKit

protocol SideMenuVCDelegate{
    func hideSideMenu()
    func didSelectCategory(_ category: Group)
}

class SideMenuVC: UIViewController {

    var delegate: SideMenuVCDelegate?
    
    @IBOutlet weak var sideMenuTableView: UITableView!

    let categories: [Group] = [.general, .business, .entertainment, .health, .science, .sports, .technology]

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
    }

    func prepareTableView() {
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        sideMenuTableView.reloadData()
    }
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath)

        let category = categories[indexPath.row]
        cell.textLabel?.text = category.group

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        print("Seçilen kategori: \(selectedCategory.group)")
        self.delegate?.didSelectCategory(selectedCategory)
//        self.delegate?.hideSideMenu()
    }
}
