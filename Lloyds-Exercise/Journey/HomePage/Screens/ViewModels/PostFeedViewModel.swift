//
//  PostFeedViewModel.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

protocol PostFeedViewModelDelegate: AnyObject {

    /// Called when a user wishes to view comments for a post
    /// - Parameter post: selected `Post` instance to fetch comments for
    func navigateToCommentsView(for post:Post)
}


class PostFeedViewModel: DataFetchingTableViewModel {

    var title: String {
        return Strings.PostList.postListViewTitle.localized
    }

    let dataSyncManager: NMDataSyncManager
    weak var delegate: PostFeedViewModelDelegate?
    
    private(set) var fetchState: FetchState = .inactive
    private(set) var postList = Posts()
    private(set) var users = Users()

    required init(networkDataManager: URLDataFetching) {
        self.dataSyncManager = NMDataSyncManager(networkDataUtility: networkDataManager)
        // self.dataPersistenceManager = DataPersistenceManager()
    }

    func fetchData() async -> FetchState {
        fetchState = .inProgress
        postList = await retrievePosts()
        users = await retrieveUsers()
        if fetchState == .inProgress {
            fetchState = .success
        }
        return fetchState
    }

    var count: Int {
        fetchState == .inProgress ? 0 : postList.count
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        if count > 0 {
            guard
                let post = post(at: indexPath.row) else {
                assertionFailure("Unable to get user/post at \(#file) \(#line)")
                return UITableViewCell()
            }
            let cell: PostCell = tableView.deque(for: indexPath)
            cell.configure(with: post.post, user: post.user)
            return cell
        } else {
            return createPlaceHolderCell(indexPath: indexPath, within: tableView)
        }
    }

    func didSelectRow(at indexPath: IndexPath, in tableView: UITableView) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = postList[indexPath.row]
        delegate?.navigateToCommentsView(for: post)
    }
}

extension PostFeedViewModel: PostsFetching {

    func retrievePosts() async -> Posts {
        let url = APIEndpoint.posts.urlString
        let result: GenericDataFetchResult<Posts> = await dataSyncManager.retrieveData(urlString: url)
        switch result {
        case let .success(postList):
            return postList
        case let .failure(error):
            print(error)
            fetchState = .fail(error: error)
            return []
        }
    }
}

extension PostFeedViewModel: UserDetailsFetching {

    func retrieveUsers() async -> Users {
        let url = APIEndpoint.users.urlString
        let result: GenericDataFetchResult<Users> = await dataSyncManager.retrieveData(urlString: url)
        switch result {
        case let .success(users):
            return users
        case let .failure(error):
            print(error)
            fetchState = .fail(error: error)
            return []
        }
    }
}

// MARK: - Private functions
private extension PostFeedViewModel {

    private func post(at index: Int) -> (post: Post, user: User)? {
        let post = postList[index]
        guard let user = users.first(where: { $0.id == post.userId }) else {
            assertionFailure("Unable to find a matching user for post, please  investigate at \(#file) \(#line)")
            return nil
        }
        return (post, user)
    }
}
