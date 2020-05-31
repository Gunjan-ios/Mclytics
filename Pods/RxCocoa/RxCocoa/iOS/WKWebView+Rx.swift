//
//  WKWebView+Rx.swift
//  RxCocoa
//
//  Created by Giuseppe Lanza on 14/02/2020.
//  Copyright © 2020 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(macOS)

import RxSwift
import WebKit

@available(iOS 8.0, OSX 10.10, OSXApplicationExtension 10.10, *)
extension Reactive where Base: WKWebView {
    
    /// Reactive wrapper for `navigationDelegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var navigationDelegate: DelegateProxy<WKWebView, WKNavigationDelegate> {
      let new =  RxWKNavigationDelegateProxy.proxy(for: base)
        return new
    }
    
    /// Reactive wrapper for `navigationDelegate` message.
    public var didCommit: Observable<WKNavigation> {
      let a =  navigationDelegate
            .methodInvoked(#selector(WKNavigationDelegate.webView(_:didCommit:)))
            .map { a in try castOrThrow(WKNavigation.self, a[1]) }
        return a
    }
    
    /// Reactive wrapper for `navigationDelegate` message.
    public var didStartLoad: Observable<WKNavigation> {
       let b = navigationDelegate
        .methodInvoked(#selector(WKNavigationDelegate.webView(_:didStartProvisionalNavigation:)))
            .map { a in try castOrThrow(WKNavigation.self, a[1]) }
        return b
    }

    /// Reactive wrapper for `navigationDelegate` message.
    public var didFinishLoad: Observable<WKNavigation> {
     let c =  navigationDelegate
            .methodInvoked(#selector(WKNavigationDelegate.webView(_:didFinish:)))
            .map { a in try castOrThrow(WKNavigation.self, a[1]) }
        return c
    }

    /// Reactive wrapper for `navigationDelegate` message.
    public var didFailLoad: Observable<(WKNavigation, Error)> {
      let d =  navigationDelegate
            .methodInvoked(#selector(WKNavigationDelegate.webView(_:didFail:withError:)))
            .map { a in
                (
                    try castOrThrow(WKNavigation.self, a[1]),
                    try castOrThrow(Error.self, a[2])
                )
            }
        return d
    }
}

#endif
