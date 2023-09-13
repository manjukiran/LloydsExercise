//
//  GenericViewModel.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UITableView

enum FetchState: Equatable {
    case inactive
    case inProgress
    case success
    case fail(error: Error)

    static func ==(lhs: FetchState, rhs: FetchState) -> Bool {
        switch (lhs, rhs) {
        case
            (.fail, .fail),
            (.inactive, .inactive),
            (.success, .success),
            (.inProgress, .inProgress):
            return true
        default:
            return false
        }
    }
}

typealias DataFetchingTableViewModel = (GenericTableViewModel
                                        & DataFetching
                                        & PlaceholderCellProviding)

/// Generic View Model Protocols
protocol GenericTableViewModel  {

    var title: String { get }

    /// Returns count of objects contained in the view model (useful for when acting as datasource for tableViews)
    ///
    /// - Returns: Count of objects
    var count: Int { get }

    /// Generate & configure cell for display in tableview
    /// - Parameters:
    ///   - tableView: tableview for which the cell is being configured
    ///   - indexPath: indexpath of the cell
    /// - Returns: `UITableViewCell` instance
    func cell(for tableView: UITableView,
              at indexPath: IndexPath) -> UITableViewCell

    /// Take action for when user selects a row in the tableview
    /// - Parameters:
    ///   - indexPath: indexpath at which the selection has occurred
    ///   - tableView: tableview reference
    func didSelectRow(at indexPath: IndexPath,
                      in tableView: UITableView)

    /// Carry out any other setup functions as needed (ex: Registering other cells with their own XIBs)
    /// - Parameter tableView: tableview for which the configurations are to be setup
    func setupAdditionalConfigurations(for tableView: UITableView)

    /// Returns height for row in tableview for indexpath
    /// - Parameter indexPath: indexpath for the cell
    /// - Returns: CGFloat value for the height of the cell
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat

    /// Returns the number of rows for the tableView
    /// - Parameter section: table view section
    /// - Returns: Returns the number of rows for the tableView
    func numberOfRowsIn(section: Int) -> Int

}

protocol PlaceholderCellProviding {

    func createPlaceHolderCell(indexPath: IndexPath,
                               within tableView: UITableView) -> UITableViewCell
}

protocol DataFetching {

    var fetchState: FetchState { get }

    /// Async function to fetch required data sets
    /// - Returns: Completion state of the fetch operation
    func fetchData() async -> FetchState
}

protocol PostsFetching: DataFetching {

    /// Function to retrieve posts list
    /// - Returns: An array of Posts.
    /// *Note:* This returns a blank array in case of a failure so that we can handle
    func retrievePosts() async -> Posts
}

protocol CommentsFetching: DataFetching {

    /// Retrieves the comments for posts
    /// - Parameter post: The post for which we are fetching the comments
    /// - Returns: An array of type  [Comment]
    func retrieveComments(for post: Post) async -> Comments
}

protocol UserDetailsFetching: DataFetching {

    /// Retrieves the user details for displaying along with posts / comments
    /// - Returns: an array of users
    func retrieveUsers() async -> Users
}
