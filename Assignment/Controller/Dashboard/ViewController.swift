//
//  ViewController.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import UIKit

class ViewController : UIViewController {
    
    
    @IBOutlet weak var tableVideos: UITableView!
    
    @IBOutlet weak var collectionFilter: UICollectionView!
    
    private let videCellIdentifier = "VideoCell"
    private let filterCellIdentifier = "FilterCell"
    
    private let viewModel = SearchViewModel()
    
    private var playVideo: Items!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableVideos.reloadData()
            }
        }
        viewModel.showError = {
            DispatchQueue.main.async {
                self.showAlert("Ops, something went wrong.")
            }
        }
        viewModel.getVideos()
        
    }
    
    func setup() {
        tableVideos.register(UINib(nibName: videCellIdentifier, bundle: nil), forCellReuseIdentifier: videCellIdentifier)

        collectionFilter.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playController = segue.destination as! PlayViewController
        playController.video = playVideo
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = viewModel.videoAt(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: videCellIdentifier, for: indexPath) as! VideoCell
        cell.configure(video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.numberOfRows - 2
        if indexPath.row == lastElement {
            viewModel.getVideos()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo = viewModel.videoAt(indexPath)
        self.performSegue(withIdentifier: "play", sender: self)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filter = viewModel.filterAt(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellIdentifier, for: indexPath) as! FilterCell
        
        cell.backgroundColor = viewModel.filterIndex == indexPath.row ? UIColor.systemTeal : UIColor.lightGray
        
        cell.lblFilter.text = filter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let lastIndex = IndexPath(row: viewModel.filterIndex, section: 0)
        let lastCell = collectionView.cellForItem(at: lastIndex)
        lastCell?.backgroundColor = UIColor.lightGray
        
        viewModel.filterBy(indexPath)
        
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.backgroundColor = UIColor.systemTeal
    }
    
}
