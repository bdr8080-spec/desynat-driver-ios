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
    @IBOutlet weak var textFiledView: CustomView!
    @IBOutlet weak var textfieldHwightConstarint: NSLayoutConstraint!
    
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
        textFiledView.isHidden = true
        textfieldHwightConstarint.constant = 0
//        textView.placeholder = "Enter reason"
    }
    
    func tableViewRegister() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
    }
    
    //    func getReason() {
    //        self.viewModel.getReason {
    //            self.tableView.reloadData()
    //        }
    //    }
    
    func getReason() {
        self.viewModel.getReason {
            // ✅ Add "Other" option manually
            let otherReason = ReasonListModel(
                id: -1,                       // Use a dummy id for "Other"
                reasonEnglish: "Other",       // This will show in the table
                reasonArabic: nil,
                type: nil,
                status: nil,
                createdAt: nil,
                updatedAt: nil
            )
            self.viewModel.reason.append(otherReason)
            
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func crossBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        guard validFields() else { return }
        
        if let index = selectedIndex {
            let selectedReason = self.viewModel.reason[index].reasonEnglish ?? ""
            
            if selectedReason.lowercased() == "other" {
                // Pass typed text
                let typedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
                onSubmitReason?(typedText)
            } else {
                // Pass selected reason
                onSubmitReason?(selectedReason)
            }
        } else {
            // If no option selected, pass textView text (if any)
            let typedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
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
        
        if let index = selectedIndex {
            let selectedReason = self.viewModel.reason[index].reasonEnglish ?? ""
            if selectedReason.lowercased() == "other" && typedText.isEmpty {
                errorMessage = .selectEnterReason
            }
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
        let previousIndex = selectedIndex
        selectedIndex = indexPath.row
        
        // Check if the selected option is "Other"
        let selectedReason = self.viewModel.reason[indexPath.row].reasonEnglish ?? ""
        if selectedReason.lowercased() == "other" {
            textFiledView.isHidden = false
            textfieldHwightConstarint.constant = 90
            textView.becomeFirstResponder() // focus textView
        } else {
            textFiledView.isHidden = true
            textfieldHwightConstarint.constant = 0
            textView.text = "" // clear text if any
        }
        
        // Animate layout change
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        
        // Reload only affected rows
        var rowsToReload = [indexPath]
        if let previous = previousIndex, previous != indexPath.row {
            rowsToReload.append(IndexPath(row: previous, section: 0))
        }
        tableView.reloadRows(at: rowsToReload, with: .automatic)
        
        // Scroll the selected row to top so it's fully visible
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
    
    
    
}

extension ReasonPopUpVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
//        textView.placeholder = ""
        let typedText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !typedText.isEmpty else { return }
        
        // If something is selected
        if let index = selectedIndex {
            let selectedReason = viewModel.reason[index].reasonEnglish?.lowercased() ?? ""
            
            // ✅ Do NOT unselect if "Other" is selected
            if selectedReason == "other" {
                return
            }
        }
        
        // ❌ Unselect only when typing without "Other"
        selectedIndex = nil
        tableView.reloadData()
    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        textView.updatePlaceholderVisibility()
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.updatePlaceholderVisibility()
//    }
    
}
