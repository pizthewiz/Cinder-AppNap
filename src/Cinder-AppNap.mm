//
//  Cinder-AppNap.mm
//  Cinder-AppNap
//
//  Created by Jean-Pierre Mouilleseaux on 21 Jan 2014.
//  Copyright 2014 Chorded Constructions. All rights reserved.
//

#import "Cinder-AppNap.h"

namespace Cinder { namespace AppNap {

ActivityRef Activity::create(const std::string reason) {
    return ActivityRef(new Activity(reason))->shared_from_this();
}

#pragma mark -

void Activity::begin() {
    if (mActivity) {
        return;
    }

#if (MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
    @autoreleasepool {
        if (![[NSProcessInfo processInfo] respondsToSelector:@selector(beginActivityWithOptions:reason:)]) {
            return;
        }

        mActivity = [[NSProcessInfo processInfo] beginActivityWithOptions:NSActivityIdleSystemSleepDisabled | NSActivitySuddenTerminationDisabled reason:@(mReason.c_str())];
        [mActivity retain];
    }
#endif
}

void Activity::end() {
    if (!mActivity) {
        return;
    }

#if (MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
    @autoreleasepool {
        if (![[NSProcessInfo processInfo] respondsToSelector:@selector(endActivity:)]) {
            return;
        }

        [[NSProcessInfo processInfo] endActivity:mActivity];
        [mActivity release];
        mActivity = NULL;
    }
#endif
}

}}
