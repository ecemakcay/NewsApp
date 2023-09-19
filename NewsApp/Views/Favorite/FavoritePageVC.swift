import UIKit

class FavoritePageVC: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteArticles: [FavoriteModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        
        let favoriteArticle = FavoritesManager.shared.getFavoriteNews()
                print(favoriteArticle)
        
    }
    
    func prepareTableView(){
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
  
}

extension FavoritePageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        
        let article = favoriteArticles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
}
