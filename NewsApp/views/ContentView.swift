//
//  ContentView.swift
//  NewsApp
//
//  Created by Samuel Shally on 12/2/23.
//

import SwiftUI

struct ContentView: View{
    
    @State private var selectedTabView = 1
    
    var body: some View{

        //Add a tab bar to the bottom of the screen
        TabView(selection: $selectedTabView){
            ViewMain()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Articles")
                }
                .tag(1)
            
            ViewBrief()
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("briefing")
                }
                .tag(2)
            
            ViewSettings()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(3)
        }
        
    }
    
}



struct ViewMain: View {
    private var news = ApiCall()
    @State private var articlesArr: [Artical] = []
    @State private var selectedTab = 0
    
    private func fetchData(){
        news.getTopHeadlines { [self] articles in
            articlesArr = articles
        }
    }
    
    var body: some View {
        //Navigation View to get title at the top
        NavigationView{
            //Make the Vstack below scrollable
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
            .onAppear{
                fetchData()
            }
        
            .navigationBarTitle("Latest Stories")
        }
    }
}

struct ViewBrief: View{
    var body: some View {
            VStack {
                Text("Hello, Brief")
            }
        }
}

struct ViewSettings: View{
    var body: some View {
            VStack {
                Text("Hello, Settings")
            }
        }
}




#Preview {
    ContentView()
}
