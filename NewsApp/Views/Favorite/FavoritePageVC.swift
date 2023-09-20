import UIKit

class FavoritePageVC: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteArticles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        favoriteArticles = FavoritesManager.shared.getFavoriteNews()
        self.favoriteTableView.reloadData()
        
        print("Favori haber sayısı: \(favoriteArticles.count)")
        
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
         favoriteArticles = FavoritesManager.shared.getFavoriteNews()
         favoriteTableView.reloadData()
         
         print("Favori haber sayısı: \(favoriteArticles.count)")
     }
    
    func prepareTableView(){
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
