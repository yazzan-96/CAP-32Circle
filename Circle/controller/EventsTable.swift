//
//  EventsTable.swift
//  Circle
//
//  Created by Yazan Alraddadi on 06/06/1443 AH.
//

import UIKit

class EventsTable: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "EventsTableCell", for: indexPath) as! EventsTableCell
//        cell.events.tag = indexPath.row

return cell

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EventsTableCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "EventsTableCell")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
