// Copyright 2021 The Brave Authors. All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest
@testable import Client

class NTPDownloaderTests: XCTestCase {

    func testIsCampaignEnded() throws {
        XCTAssert(NTPDownloader.isCampaignEnded(data: emptyJson.asData))
        XCTAssert(NTPDownloader.isCampaignEnded(data: schemaKeyJson.asData))
        XCTAssert(NTPDownloader.isCampaignEnded(data: noWallpapersJson.asData))
        
        XCTAssertFalse(NTPDownloader.isCampaignEnded(data: validJson.asData))
    }

    // MARK: - Json input
    
    private let emptyJson =
        """
        {
        }
        """
    
    // Regression test:
    // Adding schemakey to empty json caused regression on campaign invalidation logic.
    private let schemaKeyJson =
        """
        {
            "schemaVersion": 1
        }
        """
    
    private let noWallpapersJson =
        """
        {
            "schemaVersion": 1,
            "campaigns": [
                {
                    "logo": {
                        "imageUrl": "logo.png",
                        "alt": "Visit Brave.com",
                        "companyName": "Brave",
                        "destinationUrl": "https://brave.com"
                    },
                    "wallpapers": []
                }
            ]
        }
        """
    
    // Taken from an old campaign, brand replaced with Brave.
    private let validJson =
        """
        {
            "schemaVersion": 1,
            "campaigns": [
                {
                    "logo": {
                        "imageUrl": "logo.png",
                        "alt": "Visit Brave.com",
                        "destinationUrl": "https://brave.com",
                        "companyName": "Brave"
                    },
                    "wallpapers": [
                        {
                            "imageUrl": "background-1.jpg",
                            "focalPoint": {
                                "x": 696,
                                "y": 691
                            },
                            "creativeInstanceId": "18a88702-d137-4327-ab76-5fcace4c870a"
                        },
                        {
                            "imageUrl": "background-2.jpg",
                            "logo": {
                                "imageUrl": "logo-2.png",
                                "alt": "Visit basicattentiontoken.org",
                                "companyName": "BAT",
                                "destinationUrl": "https://basicattentiontoken.org"
                            }
                        },
                        {
                            "imageUrl": "background-3.jpg",
                            "focalPoint": {}
                        }
                    ]
                },
                {
                    "logo": {
                        "imageUrl": "logo.png",
                        "alt": "Visit Brave.com",
                        "destinationUrl": "https://brave.com",
                        "companyName": "Brave"
                    },
                    "wallpapers": [
                        {
                            "imageUrl": "background-4.jpg",
                            "focalPoint": {
                                "x": 696,
                                "y": 691
                            }
                        },
                        {
                            "imageUrl": "background-5.jpg",
                            "logo": {
                        "imageUrl": "logo.png",
                        "alt": "Visit Brave.com",
                        "destinationUrl": "https://brave.com",
                        "companyName": "Brave"
                            },
                            "creativeInstanceId": "54774092-04bf-45fd-86e3-9098ec418f6b"
                        }
                    ]
                }
            ]
        }
        """
}

private extension String {
    var asData: Data {
        Data(self.utf8)
    }
}
