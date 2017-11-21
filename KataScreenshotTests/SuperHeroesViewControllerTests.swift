//
//  SuperHeroesViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Sergio Gutiérrez on 22/12/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroesViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsEmptyCase() {
        givenThereAreNoSuperHeroes()

        let viewController = getSuperHerosViewController()

        verify(viewController: viewController)
    }
    
    func testShowTwoSuperherosNoAvengers() {
        _ = givenThereAreSomeSuperHeroes(2, avengers: false)

        let viewController = getSuperHerosViewController()

        verify(viewController: viewController)
    }
    
    func testShowTwoSuperherosAvengers() {
        _ = givenThereAreSomeSuperHeroes(2, avengers: true)
        
        let viewController = getSuperHerosViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowTenSuperherosNoAvengers() {
        _ = givenThereAreSomeSuperHeroes(10, avengers: false)
        
        let viewController = getSuperHerosViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowTenSuperherosAvengers() {
        _ = givenThereAreSomeSuperHeroes(10, avengers: true)
        
        let viewController = getSuperHerosViewController()
        
        verify(viewController: viewController)
    }


    fileprivate func givenThereAreSomeAvengers() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: true)
    }

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
        avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)",
                photo: URL(string: ""),
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    fileprivate func getSuperHerosViewController() -> UIViewController {
        let superHeroesViewController = ServiceLocator()
            .provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(
            ui: superHeroesViewController,
            getSuperHeroes: GetSuperHeroes(repository: repository)
        )

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]

        return rootViewController
    }
}
