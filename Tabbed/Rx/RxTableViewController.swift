//
//  RxTableViewController.swift
//  Tabbed
//
//  Created by tati on 12/22/18.
//  Copyright © 2018 ps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension RxTableViewController {
    
    // in the network layer
    func loadPost() -> Observable<Posting> {
        return Observable.create { observer in
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/5")!
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
                guard let data = data else {
                    observer.onError(CustomError.noDataFromServer)
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                
                let posting = (try? JSONDecoder().decode(Posting.self, from: data))!
                
                observer.onNext(posting)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func realObservableExample() {
        loadPost().asObservable()
                  .observeOn(MainScheduler.instance)
            .subscribe(onNext: { posting in
                print(posting)
            }, onError: { error in
                print(error)
            }).disposed(by: bag)
    }
}

class RxTableViewController: UITableViewController {
    
    fileprivate let bag = DisposeBag()
    fileprivate var presenter = NetworkExamplePresenter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // register cell
        rxDataSourceSetup()
        
        realObservableExample()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Rx DataSource Setup

extension RxTableViewController {
    func rxDataSourceSetup() {
        presenter.messages
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items( cellIdentifier: "cell")) { (index, message, cell) in
                
                        print(message)
            }.disposed(by: bag)
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        
    }
}
