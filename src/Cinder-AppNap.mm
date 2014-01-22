//
//  Cinder-AppNap.mm
//  Cinder-AppNap
//
//  Created by Jean-Pierre Mouilleseaux on 21 Jan 2014.
//  Copyright 2014 Chorded Constructions. All rights reserved.
//

#import "Cinder-AppNap.h"

namespace Cinder { namespace AppNap {

void PerformActivity(const std::string reason, std::function<void (void)> func) {
    ActivityRef activity = Activity::create(reason);
    activity->begin();
    func();
    activity->end();
}

ActivityRef Activity::create(const std::string reason) {
    return ActivityRef(new Activity(reason))->shared_from_this();
}

#pragma mark -

void Activity::begin() {
    if (mActivity) {
        return;
    }

    @autoreleasepool {
        mActivity = [[NSProcessInfo processInfo] beginActivityWithOptions:NSActivityIdleSystemSleepDisabled | NSActivitySuddenTerminationDisabled reason:@(mReason.c_str())];
        [(id<NSObject>)mActivity retain];
    }
}

void Activity::end() {
    if (!mActivity) {
        return;
    }

    @autoreleasepool {
        [[NSProcessInfo processInfo] endActivity:(id<NSObject>)mActivity];
        [(id<NSObject>)mActivity release];
        mActivity = NULL;
    }
}

}}
