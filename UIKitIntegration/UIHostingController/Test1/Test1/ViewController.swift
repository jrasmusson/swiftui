//
//  ViewController.swift
//  Test1
//
//  Created by jrasmusson on 2022-04-18.
//

import UIKit
import SwiftUI
import Combine

class ViewController: UIViewController {
    let games = [
        "Pacman",
        "Space Invaders",
        "Q*Bert",
    ]

    var tableView = UITableView()

    var cancellable: AnyCancellable!
    var delegate = ContentViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        title = "Classic Games"
        view = tableView

        self.cancellable = delegate.$name.sink { name in
            print(name)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIHostingController(rootView: GameView(game: games[indexPath.row], delegate: delegate))
        navigationController?.pushViewController(vc, animated: true)
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
    }
}
