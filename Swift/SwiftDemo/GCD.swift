//
//  GCD.swift
//  SwiftDemo
//
//  Created by 郭鹏 on 2022/2/19.
//  Copyright © 2022 郭鹏. All rights reserved.
//

import Foundation



typealias Task = (_ cancel: Bool) -> ()

@discardableResult func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task?{
    
    func dispatch_later(block: @escaping () -> ()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    
    var closure: (() -> Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let closure = closure {
            if !cancel {
                DispatchQueue.main.async(execute: closure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let result = result {
            result(false)
        }
    }

    return result
}

func cancel(_ task: Task?) {
    task?(true)
}


let a = delay(4) {
    print("hello one !")
}
let b = delay(6) {
    print("hello two !")
}

let c = delay(5) {
    cancel(a)
    cancel(b)
}

