//
//  ViewController.swift
//  TestPanda
//
//  Created by Sergey Shcheglov on 09.05.2022.
//

import UIKit

class ViewController: UIViewController {

    private let popularMovies: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = .white
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

    }

    private func setupView() {
//        view.backgroundColor = UIColor(red: 84/255, green: 144/255, blue: 64/255, alpha: 1)
//        navigationController?.navigationBar.tintColor = .white

        view.addSubview(popularMovies)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            popularMovies.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            popularMovies.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularMovies.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularMovies.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

