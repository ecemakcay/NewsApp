import Foundation

class HomeViewModel {

    let request = NetworkRequest()
    
    
    func getTopHeadlines() {
        request.fetchTopHeadlines()
    }
    
    func getEverything(){
        request.fetchEverything(query: "general")
    }

    func getSearch(query: String?){
        request.fetchEverything(query: query)
    }
    
    func getNewsForCategory(_ category: Group?) {
        let categoryQuery = category?.group.lowercased() // Kategori adını küçük harfe
        request.fetchEverything(query: categoryQuery)
        print(categoryQuery as Any)
    }

}
