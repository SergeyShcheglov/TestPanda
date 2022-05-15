//
//  ViewController.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITextFieldDelegate {
    var movies = [Movie]()
    var images = [UIImageView]()
    var viewModel = MovieListViewModel()
    var popularViewModel = PopularMovieListViewModel()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return collection
    }()
    
    let searchField: UITextField = {
        let search = UITextField()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = .white
        search.textColor = .black
        search.returnKeyType = .default
        search.layer.cornerRadius = 10
        return search
    }()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegates()
        setCollectionViewDelegates()
        loadPopularMovies()
        setupView()
    }
    
    private func setupView() {
        title = "Movie searcher"
        view.addSubview(searchField)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func loadPopularMovies() {
        popularViewModel.getPopularMovies() { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print(self.popularViewModel.popularMovieVM.count)
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchField.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        searchField.delegate = self
    }
    
    private func setCollectionViewDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    func searchMovies() {
        searchField.resignFirstResponder()
        guard let text = searchField.text, !text.isEmpty else { return }
        
        viewModel.movieVM.removeAll()
        viewModel.getMovies(query: text) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        cell?.accessoryType = .disclosureIndicator
        
        let movies = viewModel.movieVM[indexPath.row]
        cell?.movieVM = movies
        
        cell?.coverImage.sd_setImage(with: URL(string: "\(movies.posterPath)"))
        
        return cell ?? CustomTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailedVC = DetailedViewController(movie: viewModel.movieVM[indexPath.row])
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularViewModel.popularMovieVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        let imageUrl = popularViewModel.popularMovieVM[indexPath.row].posterPath
        cell?.imageView.sd_setImage(with: URL(string: "\(imageUrl)"))
        return cell ?? CustomCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 , height: 120 )
    }
}


