//
//  TabRouter.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/17/25.
//

import Combine

class TabRouter: ObservableObject {
    @Published var selectedTab: Tabs = .home
}

