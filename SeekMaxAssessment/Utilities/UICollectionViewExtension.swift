/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit

// MARK: Reusable support for UICollectionView

public extension UICollectionView {
    /**
     Register a NIB-Based `UICollectionViewCell` subclass (conforming to `Reusable` & `NibLoadable`)

     - parameter cellType: the `UICollectionViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register

     - seealso: `register(_:,forCellWithReuseIdentifier:)`
     */
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable
    {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /**
     Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)

     - parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register

     - seealso: `register(_:,forCellWithReuseIdentifier:)`
     */
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable
    {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /**
     Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type

     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue

     - returns: A `Reusable`, `UICollectionViewCell` instance

     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withReuseIdentifier:,for:)`
     */
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable
    {
        let bareCell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    /**
     Register a NIB-Based `UICollectionReusableView` subclass (conforming to `Reusable` & `NibLoadable`)
     as a Supplementary View

     - parameter supplementaryViewType: the `UIView` (`Reusable` & `NibLoadable`-conforming) subclass
     to register as Supplementary View
     - parameter elementKind: The kind of supplementary view to create.

     - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable & NibLoadable
    {
        register(
            supplementaryViewType.nib,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }

    /**
     Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View

     - parameter supplementaryViewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View
     - parameter elementKind: The kind of supplementary view to create.

     - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable
    {
        register(
            supplementaryViewType.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }

    /**
     Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type

     - parameter elementKind: The kind of supplementary view to retrieve.
     - parameter indexPath:   The index path specifying the location of the cell.
     - parameter viewType: The view class to dequeue

     - returns: A `Reusable`, `UICollectionReusableView` instance

     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:,for:)`
     */
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
    (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
        where T: Reusable
    {
        let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        )
        guard let typedView = view as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                    + "matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the supplementary view beforehand"
            )
        }
        return typedView
    }
}

/// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
/// conform to this protocol when they are *not* NIB-based but only code-based
/// to be able to dequeue them in a type-safe manner
public protocol Reusable: AnyObject {
    /// The reuse identifier to use when registering and later dequeuing a reusable cell
    static var reuseIdentifier: String { get }
}

/// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
/// conform to this typealias when they *are* NIB-based
/// to be able to dequeue them in a type-safe manner
public typealias NibReusable = Reusable & NibLoadable

// MARK: - Default implementation

public extension Reusable {
    /// By default, use the name of the class as String for its reuseIdentifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

/// Make your UIView subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: AnyObject {
    static var nibName: String { get }

    /// The nib file to use to load a new instance of the View designed in a XIB
    static var nib: UINib { get }
}

// MARK: Default implementation

public extension NibLoadable {
    static var nibName: String {
        return String(describing: self)
    }

    /// By default, use the nib which have the same name as the name of the class,
    /// and located in the bundle of that class
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}

// MARK: Support for instantiation from NIB

public extension NibLoadable where Self: UIView {
    /**
     Returns a `UIView` object instantiated from nib

     - returns: A `NibLoadable`, `UIView` instance
     */
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
