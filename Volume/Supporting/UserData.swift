//
//  FollowingData.swift
//  Volume
//
//  Created by Daniel Vebman on 12/6/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import Combine
import Foundation

class UserData: ObservableObject {
    private let articlesKey = "savedArticleIds"
    private let publicationsKey = "savedPublicationIds"
    private let isFirstLauncyKey = "isFirstLaunch"
    
    @Published private(set) var savedArticleIDs: [String] = [] {
        didSet {
            UserDefaults.standard.setValue(savedArticleIDs, forKey: articlesKey)
        }
    }
    
    @Published private(set) var followedPublicationIDs: [String] = [] {
        didSet {
            UserDefaults.standard.setValue(followedPublicationIDs, forKey: publicationsKey)
        }
    }
    
    init() {
        if let ids = UserDefaults.standard.object(forKey: articlesKey) as? [String] {
            savedArticleIDs = ids
        }
        
        if let ids = UserDefaults.standard.object(forKey: publicationsKey) as? [String] {
            followedPublicationIDs = ids
        }
    }
    
    func isArticleSaved(_ article: Article) -> Bool {
        savedArticleIDs.contains(article.id)
    }
    
    func isPublicationFollowed(_ publication: Publication) -> Bool {
        followedPublicationIDs.contains(publication.id)
    }
    
    func toggleArticleSaved(_ article: Article) {
        set(article: article, isSaved: !isArticleSaved(article))
    }
    
    func togglePublicationFollowed(_ publication: Publication) {
        set(publication: publication, isFollowed: !isPublicationFollowed(publication))
    }
    
    func set(article: Article, isSaved: Bool) {
        if isSaved {
            if !savedArticleIDs.contains(article.id) {
                savedArticleIDs.insert(article.id, at: 0)
            }
        } else {
            savedArticleIDs.removeAll(where: { $0 == article.id })
        }
    }
    
    func set(publication: Publication, isFollowed: Bool) {
        if isFollowed {
            if !followedPublicationIDs.contains(publication.id) {
                followedPublicationIDs.insert(publication.id, at: 0)
            }
        } else {
            followedPublicationIDs.removeAll(where: { $0 == publication.id })
        }
    }
}
