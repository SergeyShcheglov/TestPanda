//
//  ViewController.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
//    var movies = [Movie]()
    var viewModel = PopularMovieViewModel()
    
    private let popularMovies: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    let searchField: UITextField = {
        let search = UITextField()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = .white
        search.textColor = .black
        //        search.frame.size.height = 80
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
        // Do any additional setup after loading the view.
        setupView()
        setTableViewDelegates()
        
        
    }
    
    private func setupView() {
        //        view.backgroundColor = UIColor(ciColor: .white)
        //        navigationController?.navigationBar.tit = .white
        
        view.addSubview(popularMovies)
        view.addSubview(searchField)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
                NSLayoutConstraint.activate([
                    popularMovies.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 0),
                    popularMovies.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    popularMovies.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    popularMovies.heightAnchor.constraint(equalToConstant: 100)
                ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: popularMovies.bottomAnchor, constant: 0),
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    func searchMovies() {
        searchField.resignFirstResponder()
        guard let text = searchField.text, !text.isEmpty else { return }
        let query = text.replacingOccurrences(of: " ", with: "%20")
        viewModel.movieVM.removeAll()
        viewModel.getMovies(query: query) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
       
        
        //        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=b8a323439e1ec77ec1b324bfef77e9aa&query=\(query)")!, completionHandler: { data, response, error in
        //            guard let data = data, error == nil else { return }
        //
        //            var results: MovieResponse?
        //            do {
        //                results = try JSONDecoder().decode(MovieResponse.self, from: data)
        //            } catch {
        //                print("error")
        //            }
        //
        //            guard let finalResults = results else { return }
        //
        //            let newMovies = finalResults.results
        //            self.movies.append(contentsOf: newMovies)
        //
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
        //        }).resume()
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
        return cell ?? CustomTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
