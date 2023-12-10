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
                
                //Display all of the articles pulled from the API
                ForEach(articlesArr){ article in
                    
                    //Place each article in a rounded rectangle
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                    
                        //Overlay is the actual content
                        .overlay(
                    
                            VStack(alignment: .leading){
                                Text(article.title ?? "No Headline")
                            }.padding()
                        
                       )
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
