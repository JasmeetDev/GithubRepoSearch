//
//  RepoListViewController.swift
//  Assignment
//
//  Created by Jasmeet Singh on 15/07/21.
//

import UIKit

class RepoListViewController: UIViewController {
    /// IBOutlet(s)
    @IBOutlet weak var repoCollectionView: UICollectionView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchButton: UIButton!

    /// Variable(s)
    var viewModel: RepoListViewModelProtocol!
    
    static let cellIdentifier = RepoCollectionCell.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setUpAccessibilty()
        viewModelBindings()
        registerCell()
    }

    private func setUpAccessibilty() {
        repoCollectionView.accessibilityIdentifier = "RepoCollectionView"
        inputField.accessibilityIdentifier = "InputField"
        segmentControl.accessibilityIdentifier = "SegmentControl"
        searchButton.accessibilityIdentifier = "SearchButton"
    }
    
    private func registerCell() {
        repoCollectionView.register(UINib(nibName: RepoListViewController.cellIdentifier, bundle: nil),
                                    forCellWithReuseIdentifier: RepoListViewController.cellIdentifier)
    }
    
    private func viewModelBindings() {
        viewModel = RepoListViewModel(language: "Swift")
        
        viewModel.didFetchRepos = { [weak self] repos in
            DispatchQueue.main.async {
                self?.repoCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        if inputField.text?.isEmpty == true {
            showAlert("Please enter text.")
            return
        }
        inputField.resignFirstResponder()
        viewModel.language = inputField.text!
        viewModel.fetchRepos()
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        viewModel.sortBy = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased() ?? SortBy.stars.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RepoDetailViewController {
            destination.repo = sender as? Repo
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RepoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.repos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoListViewController.cellIdentifier,
                                                            for: indexPath) as? RepoCollectionCell else {
            fatalError("RepoCollectionCell allocation failed")
        }
        cell.repo = viewModel.repos?[indexPath.item]
        return cell
    }
}

extension RepoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let repo = viewModel.repos?[indexPath.item]
        self.performSegue(withIdentifier: "segueDetail", sender: repo)
    }
}

extension RepoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 120)
    }
}
