//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Марк Голубев on 08.12.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    // array of pictures

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        // title for View
        navigationController?.navigationBar.prefersLargeTitles = true
        // make large title for all of views in navigation stack
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        // work with file manager
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture load!
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    // MARK: - Count of rows in table
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // MARK: - Create and setup reusable cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    // MARK: - Transfer data to other VC after selecting row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // it is typecasting
            vc.selectedImage = pictures[indexPath.row]
            vc.countOfImages = pictures.count
            vc.positionOfImages = indexPath.row + 1
//            vc.positionOfImages = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

