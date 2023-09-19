import UIKit

class TableViewBox: UIView {
    
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var tableViewBoxTitle: UILabel!
    @IBOutlet weak var tableViewBoxImage: UIImageView!
    
    var article: Article?
    var favoriteArticle: FavoriteModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    @IBAction func saveBtnAct(_ sender: Any) {
        print("tableview buton tıklandı")
        if let favoriteArticle = favoriteArticle {
            FavoritesManager.shared.toggleFavoriteNews(favoriteArticle)
         
            if FavoritesManager.shared.getFavoriteNews().contains(where: { $0.title == favoriteArticle.title }) {
    
                print("Haber favorilere eklendi.")
            } else {
                // Haber favorilerden kaldırıldı
                print("Haber favorilerden kaldırıldı.")
            }
        }
    }
    
    private func setupView() {
        if let viewForXib = Bundle.main.loadNibNamed("TableViewBox", owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 15
            viewForXib.layer.borderColor = UIColor.black.cgColor
            viewForXib.layer.borderWidth = 0.5
            addSubview(viewForXib)
        }
    }
    
    func dateFormatter(article: Article) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: article.publishedAt) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd.MM.yyyy"
            
            let formattedDate = outputDateFormatter.string(from: date)
            publishedAtLabel.text = formattedDate
        }
    }
    
    func configure(with article: Article) {
        tableViewBoxTitle.text = article.title
        dateFormatter(article: article)
        loadImage(from: article.urlToImage)
        self.frame = CGRect(x: 0, y: 0, width: 355, height: 130)
        
    }
    
    func configure(with article: FavoriteModel) {
        tableViewBoxTitle.text = article.title
        
        loadImage(from: article.urlToImage)
        self.frame = CGRect(x: 0, y: 0, width: 355, height: 130)
        
    }
    
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self?.tableViewBoxImage.image = image
            }
        }.resume()
    }
}
