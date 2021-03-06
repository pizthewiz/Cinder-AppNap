//
//  Cinder-AppNap.mm
//  Cinder-AppNap
//
//  Created by Jean-Pierre Mouilleseaux on 21 Jan 2014.
//  Copyright 2014-2015 Chorded Constructions. All rights reserved.
//

#import "Cinder-AppNap.h"
#if defined(__OBJC__)
    #import <Cocoa/Cocoa.h>
#endif

namespace Cinder { namespace AppNap {

NSObject* activity;

void PerformActivity(const std::string& reason, std::function<void (void)>& func) {
    if (activity) {
        return;
    }

    BeginActivity(reason);
    func();
    EndActivity();
}

void BeginActivity(const std::string& reason) {
    if (activity) {
        return;
    }

    @autoreleasepool {
        activity = [[NSProcessInfo processInfo] beginActivityWithOptions:NSActivityIdleSystemSleepDisabled | NSActivityIdleDisplaySleepDisabled reason:@(reason.c_str())];
        [activity retain];
    }
}

void EndActivity() {
    if (!activity) {
        return;
    }

    @autoreleasepool {
        [[NSProcessInfo processInfo] endActivity:activity];
        [activity release];
        activity = nil;
    }
}

}}
