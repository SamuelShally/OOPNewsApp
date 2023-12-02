//
//  API.swift
//  NewsApp
//
//  Created by Samuel Shally on 12/2/23.
//

import Foundation

struct NestedSource: Decodable{
    let id: String
    let name: String
}

struct Artical: Decodable{
    
    let source: NestedSource
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: Date
    let content: String
}

class ApiCall{
    let key = "6365cd421fa94ed29271f9914f3e1df6"
    
    let topHeadlines = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6365cd421fa94ed29271f9914f3e1df6"
    
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
            
            
        })
        
        
        
    }
    
}
