//
//  ASwipeCell.swift
//  JZXSTools
//
//  Created by SONG JIN on 2024/10/3.
//
import UIKit
import Foundation

import SwipeCellKit

import Aquarius

open class ASwipeCell: SwipeTableViewCell, ANotificationDelegate {
    private var notification: ANotification?
    
    public static var cellHeight: CGFloat?
    public var a_inset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.notification = ANotification(notifications: [AThemeStyle.kNotification_UpdateThemeStyle])
        self.notification?.delegate = self
        
        self.a_Preview()
        self.a_Begin()
        
        self.a_UI()
        self.a_UIConfig()
        self.a_Layout()
        self.updateThemeStyle()
        self.a_Notification()
        self.a_Delegate()
        self.a_Observe()
        self.a_Bind()
        self.a_Event()
        self.a_Other()
        self.a_End()
        self.a_Inject()
    }
    
    open func a_Preview() {}
    open func a_Begin() {}
    open func a_Clear() {
        self.clearBind()
        
        self.notification?.clearNotifications()
        self.notification?.delegate = nil
    }
    
    open func a_UI() {}
    open func a_UIConfig() {}
    open func a_Layout() {}
    open func a_Notification() {}
    open func a_Delegate() {}
    open func a_Observe() {}
    open func a_Bind() {}
    open func a_Event() {}
    open func a_Other() {}
    open func a_End() {}
    open func a_Inject() {
        layoutSubviews()
    }
    open func updateThemeStyle() {}
    open func configWithCell(cellData: Any) {}
    
    @discardableResult
    public func addSubviewInContentView(view: UIView) -> Self {
        contentView.addSubview(view)
        
        return self
    }
    
    @discardableResult
    public func removeSubviewInContentView(view: UIView) -> Self {
        view.removeFromSuperview()
        
        return self
    }
    
    @discardableResult
    public func addSubviewsInContentView(views: Array<UIView>) -> Self {
        contentView.addSubviews(views: views)
        
        return self
    }
    @discardableResult
    public func removeSubviewsInContentView(views: Array<UIView>) -> Self {
        contentView.removeSubviews(views: views)
        
        return self
    }
    
    public func addNotification(notificationNames: Array<String>) {
        notification?.addNotifications(notificationNames: notificationNames)
    }
    
    public func addNotification(notificationName: String) {
        notification?.addNotification(notificationName: notificationName)
    }
    
    open func ANotificationReceive(notification: Notification) {
        if notification.name.rawValue == AThemeStyle.kNotification_UpdateThemeStyle {
            self.updateThemeStyle()
        }
    }
    //MARK: - Inject
    @objc open
    func injected()  {
        A.DEBUG { [weak self] in
            self?.a_Inject()
        }
    }
}
