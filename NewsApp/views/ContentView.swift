//
//  ContentView.swift
//  NewsApp
//
//  Created by Samuel Shally on 12/2/23.
//

import SwiftUI

struct ContentView: View {
    private var news = ApiCall()
    @State private var articlesArr: [Artical] = []
    
    private func fetchData(){
        news.getTopHeadlines { [self] articles in
            articlesArr = articles
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                ForEach(articlesArr){ article in
                    VStack(alignment: .leading){
                        Text(article.title ?? "No Headline")
                    }
                    
                }
                
            }
        }
        .padding()
        .onAppear{
            fetchData()
        }
    }
        
}

#Preview {
    ContentView()
}
