//
//  CommentsViewModel.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UITableView
import Network

class CommentsViewModel: DataFetchingTableViewModel {

    var title: String {
        post.title // Not localized as we are using the title of the post
    }

    private let post: Post
    private(set) var comments = Comments()
    private let dataSyncManager: NMDataSyncManager

    private (set) var fetchState: FetchState = .inactive

    required init(post: Post,
                  networkDataManager: URLDataFetching) {
        self.post = post
        self.dataSyncManager = NMDataSyncManager(networkDataUtility: networkDataManager)
    }

    func fetchData() async -> FetchState {
        fetchState = .inProgress
        comments = await retrieveComments(for: post)
        if case FetchState.inProgress = fetchState {
            fetchState = .success
        }
        return fetchState
    }

    var count: Int {
        fetchState == .inProgress ? 0 : comments.count
    }

    func setupAdditionalConfigurations(for tableView: UITableView) {
        tableView.register(cell: PlaceHolderCell.self,
                           nibName: PlaceHolderCell.reuseIdentifier)
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        if count > 0 {
            let comment = comments[indexPath.row]
            let cell: CommentCell = tableView.deque(for: indexPath)
            cell.configure(with: comment)
            return cell
        } else {
            return createPlaceHolderCell(indexPath: indexPath, within: tableView)
        }
    }

    func didSelectRow(at indexPath: IndexPath, in tableView: UITableView) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Do any additional actions as needed
    }

}

extension CommentsViewModel: CommentsFetching {

    func retrieveComments(for post: Post) async -> Comments {
        let url = APIEndpoint.comments(postId: post.id).urlString
        let result: GenericDataFetchResult<Comments> = await dataSyncManager.retrieveData(urlString: url)
        switch result {
        case let .success(comments):
            return comments
        case let .failure(error):
            print(error)
            fetchState = .fail(error: error)
            return []
        }
    }
}
