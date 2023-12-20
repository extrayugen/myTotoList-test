import UIKit

protocol DatePickerDelegate: AnyObject {
    func didSelectDate(date: Date)
}

class DatePickerViewController: UIViewController {
    weak var delegate: DatePickerDelegate?
    var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        view.addSubview(datePicker)
    }

    @objc func dateChanged(_ sender: UIDatePicker) {
        delegate?.didSelectDate(date: sender.date)
        dismiss(animated: true, completion: nil)
    }
    
}
