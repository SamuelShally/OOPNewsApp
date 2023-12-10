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
    
    //Completion handler will return type artical
    func getTopHeadlines(completionHandler: @escaping ([Artical]) -> Void){
        
        let topHeadlines = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(key)"
    
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
    
    func createBriefing(completionHandler: @escaping ([Artical]) -> Void){
        
        var sources: [String] = []
        
        var wsj: Bool
        var bbc: Bool
        var cnn: Bool
        var reuters: Bool

        wsj = UserDefaults.standard.object(forKey: "wsj") as? Bool ?? true
        bbc = UserDefaults.standard.object(forKey: "bbc") as? Bool ?? true
        cnn = UserDefaults.standard.object(forKey: "cnn") as? Bool ?? true
        reuters = UserDefaults.standard.object(forKey: "reuters") as? Bool ?? true
        
        if(wsj){sources.append("the-wall-street-journal")}
        if(bbc){sources.append("bbc-news")}
        if(cnn){sources.append("cnn")}
        if(reuters){sources.append("reuters")}
        
        let sourcesString = sources.joined(separator: ",")
        
        let briefingURL = "https://newsapi.org/v2/top-headlines?sources=\(sourcesString)&apiKey=\(key)"
        
       print(briefingURL)
            
        let url = URL(string: briefingURL)
        
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


