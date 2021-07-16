//
//  RepoDetailViewController.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import UIKit

class RepoDetailViewController: UIViewController {
    /// IBOutlet(s)
    @IBOutlet weak var repoDetailTableView: UITableView!
    
    /// Variable(s)
    var viewModel: RepoDetailViewModelProtocol!
    var repo: Repo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        registerCell()
        viewModelBindings()
        self.title = repo?.name
    }
    
    private func registerCell() {
        repoDetailTableView.register(UINib(nibName: RepoDetailTableCell.className, bundle: nil), forCellReuseIdentifier: RepoDetailTableCell.className)
    }
    
    private func viewModelBindings() {
        guard let name = repo?.fullName else {
            return
        }
        viewModel = RepoDetailViewModel(repo: name)
        
        viewModel.didFetchRepoDetail = { [weak self] in
            DispatchQueue.main.async {
                self?.repoDetailTableView.reloadData()
            }
        }

        fetchDetail()
    }
    
    private func fetchDetail() {
        viewModel.fetchRepoDetail()
    }
}

extension RepoDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.contributors?.count ?? 0
        case 1:
            return viewModel.issues?.count ?? 0
        case 2:
            return viewModel.comments?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoDetailTableCell.className, for: indexPath) as? RepoDetailTableCell else { 
         fatalError("RepoDetailTableCell allocation failed")
        }
        if indexPath.section == 0 {
            cell.contentLabel.text = viewModel.contributors?[indexPath.row].name
        } else if indexPath.section == 1 {
            cell.contentLabel.text = viewModel.issues?[indexPath.row].title
        } else if indexPath.section == 2 {
            cell.contentLabel.text = viewModel.comments?[indexPath.row].body
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].description
    }
}

extension RepoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
