//
//  ReasonPopUpVC.swift
//  DesynatDriver
//
//  Created by Chandra Prakash on 24/12/25.
//

import UIKit

class ReasonPopUpVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: TableViewDynamicHeight!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: VARIABLE
    let viewModel = DeliveriesViewModel()
    var selectedIndex: Int?
    var onSubmitReason: ((_ reasonText: String) -> Void)?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        getReason()
        textView.delegate = self
    }
    
    func tableViewRegister() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
    }
    
    func getReason() {
        self.viewModel.getReason {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        guard validFields() else { return }

            let typedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)

            if let index = selectedIndex {
                let reasonText = self.viewModel.reason[index].reasonEnglish ?? ""
                onSubmitReason?(reasonText)
            } else {
                onSubmitReason?(typedText)
            }

            self.dismiss(animated: true)
    }
    
    func validFields() -> Bool {
        var errorMessage: AlertConstant = .none

        let typedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)

        if selectedIndex == nil && typedText.isEmpty {
            errorMessage = .selectOrEnterReason
        }

        if errorMessage != .none {
            self.showAlert(msg: errorMessage.rawValue)
        }

        self.view.endEditing(true)
        return errorMessage == .none
    }

}

extension ReasonPopUpVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.reason.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
        let isSelected = indexPath.row == selectedIndex
        let imageName = isSelected ? "radioSelected" : "radioUnselected"
        
        cell.config(self.viewModel.reason[indexPath.row].reasonEnglish ?? "", imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        textView.text = ""
        tableView.reloadData()
    }

}

extension ReasonPopUpVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            selectedIndex = nil
            tableView.reloadData()
        }
    }
}

