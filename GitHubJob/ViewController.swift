//
//  ViewController.swift
//  GitHubJob
//
//  Created by Sergey Koriukin on 03.10.2018.
//  Copyright © 2018 Sergey Koriukin. All rights reserved.
//

import UIKit
import Foundation
import Alamofire




 //fileprivate




class ViewController: UIViewController {
    
    
     var items = [Item]()
   
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
       
            
        }
        
        
    
    
    
     @IBOutlet weak var UserText: UITextField!
    
    
   
    @IBAction func searchButton(_ sender: Any) {
  
        
     let userText2 = UserText.text?.lowercased()
        
     let gitUrl:String = "https://jobs.github.com/positions.json?search="
        
    for i in 0...8 {
    //закрытие клавиатуры
//--------------------------------------alamofire------------------------------------------------------------------
    let pageNumder = String(i)
        
        
    Alamofire.request(gitUrl + userText2! + "&amp;page=" + pageNumder, method: .get).responseJSON { response in
                    guard response.result.isSuccess else {                  //Возвращает значение "true", если результат успешен
                        print("Ошибка при запросе данных\(String(describing: response.result.error))")
                        return
                    }
                    
        
                    guard let arrayOfItems = response.result.value as? [[String:AnyObject]]
                        else {
                            print("Не могу перевести в массив")
                            return
                    }
                    
                    
             
                    
                    for itm in arrayOfItems {
                        let item = Item(
                         
                            title: itm["title"] as? String ?? "Defolt",
                            
                            location: itm["location"] as? String ?? "Defolt",
                            
                            company_logo: itm["company_logo"] as? String ?? "Defolt",
                            
                            details: itm["description"] as? String ?? "DefoltInfo"
                            
                            
                        )
                        self.items.append(item)
                    }
                    
                }
                
        }
                
               UserText.resignFirstResponder()

       
    
            
              DispatchQueue.main.async {
                self.TableView.reloadData()
             }
        
        
        
    
    }   //Button
    
    
    
               override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
              // Dispose of any resources that can be recreated.
              }
    
        
   
   
    
    }  //ViewController

    

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // метод устанавливает количество строк по поличеосту элементов в массиве с объектами.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // метод который возвращает ячейку таблицы для нужной строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ItemCell
        configureCell(cell: cell, for: indexPath)
        return cell
    }
    
    
    
   
        
        
    private func configureCell(cell: ItemCell, for indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        cell.locationLabel.text = "\(item.location)"
        cell.titleLabel.text = "\(item.title)  "
       // cell.infoLabel.text = "\(item.info)"
        
        if item.company_logo == "Defolt" {
            cell.companyLogo?.downloadedFrom(link: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Umbrella_Corporation_logo.svg/1200px-Umbrella_Corporation_logo.svg.png")
            
        }else{
            cell.companyLogo?.downloadedFrom(link: item.company_logo)
            
            
           
            
            }
            
        }
        
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      var destinationSVC: SecondViewController = segue.destination as! SecondViewController
   //      destinationSVC.infoText = item.info
        
  //  }
    
   
}

extension ViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SecondViewController, let cell = sender as? UITableViewCell {
            let indexPath = TableView.indexPath(for: cell)!
            let listing = items[indexPath.row]
            viewController.listing = listing
        }
      //  if let viewController = segue.destination as? FilterViewController {
      //      viewController.location = location
       //     viewController.delegate = self
      //  }
    }
    
}
