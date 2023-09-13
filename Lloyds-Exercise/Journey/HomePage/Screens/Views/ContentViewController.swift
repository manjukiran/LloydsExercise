//
//  ContentViewController.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, StoryboardInstantiable {


    weak var appCoordinating: Coordinating?
    var viewModel: DataFetchingTableViewModel?

    @IBOutlet var tableView: UITableView!

    /// Creates ContentViewController instance when injected with a view model
    ///
    /// - Parameter DataFetchingTableViewModel: view model object to act as the data source
    /// - Returns: ContentViewController object
    static func create(_ viewModel: DataFetchingTableViewModel) -> ContentViewController? {
        if let vc = ContentViewController.instantiate() {
            vc.viewModel = viewModel
            return vc
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        refreshData()
    }

    private func setupUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        title = viewModel.title
    }

    private func setupTableView() {
        configureRefreshControl()
        viewModel?.setupAdditionalConfigurations(for: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120.0
        tableView.accessibilityIdentifier = AccessibilityIdentifier.GenericContentFeedScreen.tableView
    }

    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = LETheme.shared.themeColor
        refreshControl.attributedTitle = NSAttributedString(string: Strings.GenericContentListView.dataFetchInProgress.localized)
        refreshControl.addTarget(self,
                                 action: #selector(refreshData),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func refreshData() {
        tableView.refreshControl?.beginRefreshing()
        Task {
            let _ = await viewModel?.fetchData()
            UIView.runOnMainThread { [weak self] in
                guard let self = self else { return }
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

}

extension ContentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(at: indexPath, in: tableView)
    }
    
}

extension ContentViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.heightForRowAt(at: indexPath) ?? 0.0
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsIn(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            assertionFailure("ViewModel not instantiated")
            return UITableViewCell()
        }
        let cell = viewModel.cell(for: tableView, at: indexPath)
        cell.accessibilityIdentifier = AccessibilityIdentifier.GenericContentFeedScreen.tableViewCellPrefix + "_\(indexPath.section)_\(indexPath.row)"
        return cell
    }

}
