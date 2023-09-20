import UIKit

class TableViewBox: UIView {
    
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var tableViewBoxTitle: UILabel!
    @IBOutlet weak var tableViewBoxImage: UIImageView!
    
    var article: Article?
    var favoriteArticle: Article?
    
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
        if let article = article {
            FavoritesManager.shared.toggleFavoriteNews(article)
            
            if FavoritesManager.shared.getFavoriteNews().contains(where: { $0.title == article.title }) {
                print("Haber favorilere eklendi.")
            } else {
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
    
    func configure(with article: Article?) {
        self.article = article
        tableViewBoxTitle.text = article?.title
        dateFormatter(article: article!)
        loadImage(from: article?.urlToImage)
        self.frame = CGRect(x: 10, y: 10, width: 355, height: 130)
        
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
