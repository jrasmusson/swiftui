//
//  ViewController.swift
//  Test1
//
//  Created by jrasmusson on 2022-04-18.
//

import UIKit
import SwiftUI
import Combine

struct Game {
    let name: String
    var rating: String? = nil
}

class ViewController: UIViewController {
    var games = [
        Game(name: "Pacman")
    ]

    var tableView = UITableView()
    var selectedGameName = ""

    // SwiftUI
    var delegate = GameViewDelegate()
    var cancellable: AnyCancellable!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        title = "Arcade Classics"
        view = tableView

        // Subscriber bound to published property name
        // Note: The return value should be held, otherwise the stream will be canceled.
        self.cancellable = delegate.$rating.sink { rating in

            if let index = self.games.firstIndex(where: { $0.name == self.selectedGameName }) {
                self.games[index].rating = "⭐️"
                self.tableView.reloadData()
            }

            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(games[indexPath.row].name)  \(games[indexPath.row].rating ?? "")"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // UIKit > SwiftUI
        selectedGameName = games[indexPath.row].name
        let vc = UIHostingController(rootView: GameView(name: selectedGameName, delegate: delegate))
        navigationController?.pushViewController(vc, animated: true)
    }
}
