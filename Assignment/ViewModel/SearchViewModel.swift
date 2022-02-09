//
//  SearchViewModel.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import Foundation
import Network


class SearchViewModel {
    
    var videoItems = [Items]()
    var nextPageToken: String?
    var reloadTableView: (() -> ())?
    var showError: (() -> ())?
    
    var filterIndex = 0
    
    var filters = ["Music", "Sports", "Gaming", "Pets & Animals", "Film & Animation"]
    
    init() {
        
    }
    
    func getVideos() {
        
        APIClient.getVideos(query: filters[filterIndex], nextPageToken: nextPageToken) { [weak self] result in
            switch result {
                case .success(let video):
                    self?.nextPageToken = video.nextPageToken
                    self?.videoItems.append(contentsOf: video.items)
                    self?.reloadTableView?()
                case .failure(let error):
                    self?.showError?()
                    print(error)
            }
        }
    }
    
    private func reset() {
        nextPageToken = nil
        videoItems.removeAll()
        reloadTableView?()
    }
    
    var numberOfRows: Int {
        return videoItems.count
    }
    
    func videoAt(_ index: IndexPath) -> Items {
        return videoItems[index.row]
    }
    
    func filterAt(_ index: IndexPath) -> String {
        return filters[index.row]
    }
    
    func filterBy(_ index: IndexPath) {
        filterIndex = index.row
        reset()
        getVideos()
    }
    
}
