//
//  HomeList.swift
//  Volume
//
//  Created by Cameron Russell on 10/30/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import Combine
import SwiftUI

struct HomeList: View {
    @State private var cancellableQuery: AnyCancellable?
    @State private var state: HomeListState = .loading
    @EnvironmentObject private var userData: UserData

    private var isLoading: Bool {
        switch state {
        case .loading:
            return true
        default:
            return false
        }
    }

    private func fetch() {
        guard isLoading else { return }

        guard let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
            return
        }
        
        guard let twoWeeksAgo = Calendar.current.date(byAdding: .day, value: -14, to: Date()) else {
            return
        }
        
        let trendingQuery = Network.shared.apollo.fetch(
            query: GetTrendingArticlesQuery(since: oneWeekAgo.dateString)
        )
        
        let followedQuery = userData.followedPublicationIDs.publisher
            .flatMap { id in
                Network.shared.apollo.fetch(query: GetArticlesByPublicationIdQuery(id: id))
            }
            .map(\.articles)
            .collect()
        
        let otherQuery = Network.shared.apollo.fetch(
            query: GetArticlesAfterDateQuery(since: twoWeeksAgo.dateString, limit: 20)
        )
        
        cancellableQuery = Publishers.Zip3(trendingQuery, followedQuery, otherQuery)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { (trending, followed, other) in
                // Take up to 10 random followed articles
                let followedArticles = Array(followed.joined().shuffled().prefix(10))
                // Exclude followed articles from trending articles
                let trendingArticles = trending.articles.filter { article in
                    !followedArticles.contains(where: { $0.id == article.id })
                }
                // Exclude followed and trending articles from other articles
                let otherArticles = other.articles.filter { article in
                    !(followedArticles.contains(where: { $0.id == article.id })
                        || trendingArticles.contains(where: { $0.id == article.id }))
                }
                
                withAnimation(.linear(duration: 0.1)) { 
                    state = .results((
                        trendingArticles: [Article](trendingArticles),
                        followedArticles: [Article](followedArticles),
                        otherArticles: [Article](otherArticles)
                    ))
                }
            }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    Header("The Big Read").padding(.bottom, -12)
                    ScrollView(.horizontal, showsIndicators: false) {
                        switch state {
                        case .loading:
                            HStack(spacing: 24) {
                                ForEach(0..<2) { _ in
                                    BigReadArticleRow.Skeleton()
                                }
                            }
                        case .results(let results):
                            LazyHStack(spacing: 24) {
                                ForEach(results.trendingArticles) { article in
                                    BigReadArticleRow(article: article)
                                }
                            }
                        }
                    }
                    .padding([.bottom, .leading, .trailing])
                    
                    Header("Following").padding(.bottom, -12)
                    switch state {
                    case .loading:
                        ForEach(0..<5) { _ in
                            ArticleRow.Skeleton()
                                .padding([.bottom, .leading, .trailing])
                        }
                    case .results(let results):
                        ForEach(results.followedArticles) { article in
                            ArticleRow(article: article)
                                .padding([.bottom, .leading, .trailing])
                        }
                    }
                    
                    VolumeMessage(message: .upToDate)
                        .padding([.top, .bottom], 25)
                    
                    Header("Other Articles").padding(.bottom, -12)
                    switch state {
                    case .loading:
                        // will be off the page, so pointless to show anything
                        Spacer().frame(height: 0)
                    case .results(let results):
                        ForEach(results.otherArticles) { article in
                            ArticleRow(article: article)
                                .padding([.bottom, .leading, .trailing])
                        }
                    }
                }
            }
            .disabled(isLoading)
            .padding(.top)
            .background(Color.volume.backgroundGray)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image("volume-logo")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: fetch)
        }
    }
}

extension HomeList {
    typealias Results = (
        trendingArticles: [Article],
        followedArticles: [Article],
        otherArticles: [Article]
    )
    private enum HomeListState {
        case loading
        case results(Results)
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}
