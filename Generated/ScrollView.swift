//
// Autogenerated by gaxb at 04:18:05 PM on 04/29/15
//

import UIKit

public class ScrollView: ScrollViewBase {
	lazy public var scrollView = UIScrollView(frame: CGRect.zero)
	override public var view: UIView {
		get {
			return scrollView
		}
		set {
			if newValue is UIScrollView {
				scrollView = newValue as! UIScrollView
			}
		}
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
		if contentSize != nil {
			scrollView.contentSize = contentSize!
		}
#if os(iOS)
		if pagingEnabled != nil {
			scrollView.isPagingEnabled = pagingEnabled!
		}
#endif
		if showsHorizontalScrollIndicator != nil {
			scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator!
		}
		if showsVerticalScrollIndicator != nil {
			scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator!
		}
	}
}
