//  XCUIElementSnapshotHelpers
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest

// Convenience helpers on XCUIElementSnapshot to access children of specific types
extension XCUIElementSnapshot {
    public var buttons: [XCUIElementSnapshot] {
        children.filter {
            $0.elementType == .button
        }
    }

    public var alerts: [XCUIElementSnapshot] {
        children.filter {
            $0.elementType == .alert
        }
    }

    public var cells: [XCUIElementSnapshot] {
        children.filter {
            $0.elementType == .cell
        }
    }

    public var switches: [XCUIElementSnapshot] {
        children.filter {
            $0.elementType == .switch
        }
    }

    public var staticTexts: [XCUIElementSnapshot] {
        children.filter {
            $0.elementType == .staticText
        }
    }
}
