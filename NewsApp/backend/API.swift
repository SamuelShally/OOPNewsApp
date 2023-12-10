//
//  API.swift
//  NewsApp
//
//  Created by Samuel Shally on 12/2/23.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Artical]
}

struct Artical: Decodable, Identifiable {
    struct Source: Decodable {
        let id: String?
        let name: String?
    }

    let id = UUID()
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}


class ApiCall{
    let key = "6365cd421fa94ed29271f9914f3e1df6"
    
    let topHeadlines = "https://newsapi.org/v2/top-headlines?country=us&apiKey=6365cd421fa94ed29271f9914f3e1df6"
    
//    let topHeadlines = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6365cd421fa94ed29271f9914f3e1df6"
    
    //Completion handler will return type artical
    func getTopHeadlines(completionHandler: @escaping ([Artical]) -> Void){
    
    
        let url = URL(string: topHeadlines)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
        
            //Check if there was an error accessing the API
            if let error = error{
                print("Error in accessing the API")
                return
            }
            
            //If the above is successful, decode the returned JSON
            if let data = data {
                do {
                    
//                    let jsonString = String(data: data, encoding: .utf8)
//                    print("Received JSON: \(jsonString ?? "")")
                    
                    let decoder = JSONDecoder()
                    let articles = try decoder.decode(NewsResponse.self, from: data)
                    completionHandler(articles.articles)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        })
        task.resume()
    }
}
