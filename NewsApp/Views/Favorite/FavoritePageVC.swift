import UIKit

class FavoritePageVC: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet var mainView: UIView!
    var favoriteArticles: [Article] = []
    let viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
        prepareTableView()
        favoriteArticles = viewModel.getFavoriteNews()
        self.favoriteTableView.reloadData()
        viewSetUp()
        print("Favorite news count: \(favoriteArticles.count)")
        
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        favoriteArticles = viewModel.getFavoriteNews()
        self.favoriteTableView.reloadData()
         viewSetUp()
         print("Favorite news count: \(favoriteArticles.count)")
     }
    
    func prepareTableView(){
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
  
    func viewSetUp(){
        if favoriteArticles.count == 0 {
            mainView.isHidden = true
            emptyView.isHidden = false
        }else{
            emptyView.isHidden = true
            mainView.isHidden = false
        }
        
        topView.layer.cornerRadius = 20
    }
    
}

extension FavoritePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        
        let article = favoriteArticles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailPageVC", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailPageVC") as? DetailPageVC {
                detailVC.article = favoriteArticles[indexPath.row]
                navigationController?.pushViewController(detailVC, animated: true)
            }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            let favorite = self.favoriteArticles[indexPath.row]

            let alert = UIAlertController(title: "Delete", message: "Do you want to delete?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancel)

            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
                self.viewModel.delete(favorite)
                
                self.favoriteArticles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.reloadData()
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
