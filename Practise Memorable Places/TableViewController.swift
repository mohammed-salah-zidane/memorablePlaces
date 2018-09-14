//
//  TableViewController.swift
//  Practise Memorable Places
//
//  Created by Mohamed Salah Zidane on 7/31/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
var places = [Dictionary<String,String>()]
var activePlaces = -1
class TableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
       activePlaces = -1
        if let tempPlaecs = UserDefaults.standard.object(forKey: "places") as? [Dictionary<String,String>]{
            places = tempPlaecs
        }
        if places.count == 1 && places[0].count == 0{
            places.remove(at: 0)
            places.append(["name": "Taj Mahal", "lat" : "27.17527","long": "78.042128"])
            
            UserDefaults.standard.set(places, forKey: "places")
        }
        table.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activePlaces = indexPath.row
        performSegue(withIdentifier:"toMap" , sender: nil)
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = places[indexPath.row]["name"]
        // Configure the cell...
        return cell
    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            places.remove(at: indexPath.row)
            UserDefaults.standard.set(places, forKey: "places")
            table.reloadData()
        }
    }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
