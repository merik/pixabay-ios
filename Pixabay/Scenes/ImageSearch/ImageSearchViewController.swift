//
//  ImageSearchViewController.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class ImageSearchViewController: UIViewController {

    private let repository = ApiRepository()
    
    @IBOutlet weak var loadingStatusView: LoadingStatusView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: ImagesTableView!
    
    private lazy var viewModel: ImageSearchViewModel = {
        let viewModel = ImageSearchViewModel(repository: repository)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Pixabay"
        configureSearchBar()
        bindToViewModel()
    }
    
    private func configureSearchBar() {
        searchBar.backgroundImage = UIImage.imageFromColor(.lightGray)
        searchBar.prompt = "Pixabay"
        searchBar.changePromptFont(UIFont.systemFont(ofSize: 16, weight: .heavy))
       
        searchBar.placeholder = "Search"
       searchBar.delegate = self
    }

    private func bindToViewModel() {
        viewModel.didFinishSearching = {[weak self] result in
            DispatchQueue.main.async {
                self?.updateUI(result)
            }
        }
    }
    
    private func updateUI(_ result: ImageSearchResult) {
        loadingStatusView.status = result
        switch result {
        case .success(let images):
            tableView.isHidden = false
            tableView.images = images
        case .searching:
            tableView.isHidden = true
            searchBar.resignFirstResponder()
        case .error:
            tableView.isHidden = true
        case .notFound:
            tableView.isHidden = true
        }
    }
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text ?? ""
        viewModel.searchImages(with: keyword)
    }
}

