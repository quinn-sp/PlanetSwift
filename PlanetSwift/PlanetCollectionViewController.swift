//
//  PlanetCollectionViewController.swift
//  Planned
//
//  Created by Quinn McHenry on 12/2/15.
//  Copyright (c) 2015 Small Planet Digital. All rights reserved.
//


public protocol PlanetCollectionViewTemplate {
    var reuseId: String { get }
    var size: TemplateSize { get }
    func decorate(_ cell: UICollectionViewCell)
}

public struct TemplateSize: OptionSet {
    public let rawValue: Int
    
    public static let FullHeight = TemplateSize(rawValue: 1 << 0)
    public static let FullWidth = TemplateSize(rawValue: 1 << 1)
    public static let HalfWidth = TemplateSize(rawValue: 1 << 2)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}


public protocol PlanetCollectionViewCell: class {
    var bundlePath: String { get }
    var xmlView: View? { get set }
    func loadView()
}

public extension PlanetCollectionViewCell where Self: UICollectionViewCell {
    
    func loadView() {
        guard xmlView == nil else { return }
        
        xmlView = PlanetUI.readFromFile(String(bundlePath: bundlePath)) as? View
        guard let xmlView = xmlView else {
            // failed to create xml view from bundlePath \(bundlePath)
            return
        }
        contentView.addSubview(xmlView.view)
        xmlView.visit() { $0.gaxbDidPrepare() }
        
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .width))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .height))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .left))
        addConstraint(NSLayoutConstraint(item: xmlView.view, toItem: contentView, equalAttribute: .top))
        xmlView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}


public class PlanetCollectionViewController: PlanetViewController {
    
    @IBOutlet weak public var collectionView: UICollectionView!
    public var cellReferences = [String: PlanetCollectionViewCell]()
    public var cellMapping: [String: PlanetCollectionViewCell.Type] { return [:] }
    public var cellSizes: [[CGSize]] = []
    public var objects: [[PlanetCollectionViewTemplate]] = [] {
        didSet {
            cellSizes.removeAll(keepingCapacity: false)
            for subarray in objects {
                cellSizes.append([CGSize](repeating: CGSize.zero, count: subarray.count))
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.contentOffset = CGPoint.zero
    }
    
    public func configureCollectionView() {
        for (cellId, cellClass) in cellMapping {
            collectionView?.register(cellClass, forCellWithReuseIdentifier: cellId)
        }
        collectionView?.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
    }
    
    // MARK: - Collection View Cell Handling
    
    public func configure(_ cell: PlanetCollectionViewCell?, atIndexPath indexPath: IndexPath) {
        cell?.loadView()
        guard let xmlView = cell?.xmlView,
            let template = cellObject(indexPath),
            let cell = cell as? UICollectionViewCell
            else { return }
        if template.size.contains(.FullWidth) {
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: (indexPath as NSIndexPath).section)
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: collectionView.frame.size.width - insets.left - insets.right)
            xmlView.view.addConstraint(constraint)
        }
        if template.size.contains(.HalfWidth) {
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: (indexPath as NSIndexPath).section)
            let constant = (collectionView.frame.size.width - insets.left - insets.right - max(insets.right, insets.left)) / 2
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: floor(constant))
            xmlView.view.addConstraint(constraint)
        }
        if template.size.contains(.FullHeight) {
            let insets = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAtIndex: (indexPath as NSIndexPath).section)
            let constraint = NSLayoutConstraint(item: xmlView.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: collectionView.frame.size.height - insets.top - insets.bottom)
            xmlView.view.addConstraint(constraint)
        }
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func cellMapping(_ reuseId: String) -> PlanetCollectionViewCell.Type? {
        return cellMapping[reuseId]
    }
    
    public func reuseIdentifier(_ indexPath:IndexPath) -> String {
        guard let reuseId = cellObject(indexPath)?.reuseId else {
            // cell template not found
            return ""
        }
        return reuseId
    }
    
    public func cellObject(_ indexPath: IndexPath) -> PlanetCollectionViewTemplate? {
        return objects[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func cellSize(_ indexPath: IndexPath) -> CGSize? {
        return cellSizes[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
    }
    
    public func setCellSize(_ size: CGSize, forIndexPath indexPath:IndexPath) {
        cellSizes[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] = size
    }
    
    public func cellHeight(_ indexPath: IndexPath) -> CGFloat? {
        return (cellSize(indexPath) ?? CGSize.zero).height
    }
    
    public func setCellHeight(_ height: CGFloat, forIndexPath indexPath: IndexPath) {
        if let size = cellSize(indexPath) {
            setCellSize(CGSize(width: size.width, height: height), forIndexPath:indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var size = cellSize(indexPath) ?? CGSize.zero
        if let template = cellObject(indexPath), size == CGSize.zero {
            let reuseId = reuseIdentifier(indexPath)
            
            var cellReference: PlanetCollectionViewCell? = cellReferences[reuseId]
            if cellReference == nil {
                if let cellReferenceType = cellMapping(reuseId) as? UICollectionViewCell.Type {
                    cellReference = cellReferenceType.init() as? PlanetCollectionViewCell
                }
                configure(cellReference!, atIndexPath: indexPath)
                cellReferences[reuseId] = cellReference
            }
            configure(cellReference!, atIndexPath: indexPath)
            template.decorate(cellReference as! UICollectionViewCell)
            
            let xmlView = cellReference?.xmlView
            size = xmlView?.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize) ?? CGSize.zero
            setCellSize(size, forIndexPath: indexPath)
        }
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: section == 0 ? 64 : 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension PlanetCollectionViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return objects.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier(indexPath), for: indexPath)
        configure(cell as? PlanetCollectionViewCell, atIndexPath: indexPath)
        cellObject(indexPath)?.decorate(cell)
        return cell
    }
    
}

extension PlanetCollectionViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = false
    }
    
}
