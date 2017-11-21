//
//  SuperHeroTableViewCellTests.swift
//  KataScreenshot
//
//  Created by Sergio Gutiérrez on 09/01/17.
//  Copyright © 2017 Karumi. All rights reserved.
//

import UIKit
import XCTest
@testable import KataScreenshot

class SuperHeroTableViewCellTests: ScreenshotTest {
    let repo = MockSuperHeroesRepository()
    
    func testShowsAvengersBadgeIfNotAvenger() {
        givenOneSuperheroInRepo(isAvenger: false)
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: repo.superHeroes.first!)
        
        verify(view: cell)
    }
    
    func testShowsAvengersBadgeIfAvenger() {
        givenOneSuperheroInRepo(isAvenger: true)
        
        let cell = givenASuperHeroTableViewCell()
        cell.configure(forItem: repo.superHeroes.first!)
        
        verify(view: cell)
    }

    
    private func givenASuperHeroTableViewCell() -> SuperHeroTableViewCell {
        return UINib(nibName: "SuperHeroTableViewCell", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! SuperHeroTableViewCell
    }
    
    private func givenOneSuperheroInRepo(isAvenger: Bool) {
        let superHero = SuperHero(name: "SuperHero PEPE",
                              photo: URL(string: ""),
                              isAvenger: isAvenger,
                              description: "Description - PEPE ES GENIAL")
        repo.superHeroes = [superHero]
    }
}
