//
//  GenericTableViewModel+Extensions.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UITableView

extension GenericTableViewModel {

    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func numberOfRowsIn(section: Int) -> Int {
        count > 0
        ? count
        : 1 // For Placeholder cell
    }
}

extension GenericTableViewModel where Self: DataFetching & PlaceholderCellProviding {

    func numberOfRowsIn(section: Int) -> Int {
        (fetchState == .inProgress || fetchState == .inactive)
        ? 0
        : count > 0
            ? count
            : 1 // For Placeholder cell
    }

    func setupAdditionalConfigurations(for tableView: UITableView) {
        tableView.register(cell: PlaceHolderCell.self,
                           nibName: PlaceHolderCell.reuseIdentifier)
    }

    func createPlaceHolderCell(indexPath: IndexPath,
                               within tableView: UITableView) -> UITableViewCell {
        // Placeholder cell when no data is received from the backend
        let cell: PlaceHolderCell = tableView.deque(for: indexPath)

        cell.configureCell(imageName: "no_data_icon",
                           text: Strings.GenericContentListView.noDataPlaceholderMessage.localized)
        return cell
    }
}
