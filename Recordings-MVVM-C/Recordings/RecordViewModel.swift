import Foundation
import RxSwift
import RxRelay

final class RecordViewModel {
	// Inputs
	var folder: Folder? = nil
	let recording = Recording(name: "", uuid: UUID())
	let duration = BehaviorRelay<TimeInterval>(value: 0)
	
	// Actions
	func recordingStopped(title: String?) {
		guard let title = title else {
			recording.deleted()
			return
		}
		recording.setName(title)
		folder?.add(recording)
	}
	
	func recorderStateChanged(time: TimeInterval?) {
		if let t = time {
			duration.accept(t)
		} else {
			dismiss?()
		}

	}
	
	// Outputs
	var timeLabelText: Observable<String?> {
		return duration.asObservable().map(timeString)
	}
	
	var dismiss: (() -> ())?
}
