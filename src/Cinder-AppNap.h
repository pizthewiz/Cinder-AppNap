//
//  Cinder-AppNap.h
//  Cinder-AppNap
//
//  Created by Jean-Pierre Mouilleseaux on 21 Jan 2014.
//  Copyright 2014 Chorded Constructions. All rights reserved.
//

#pragma once

#if !defined(CINDER_MAC)
    #error Target platform unsupported by Cinder-AppNap
#endif

#import "cinder/Cinder.h"

namespace Cinder { namespace AppNap {

void PerformActivity(const std::string reason, std::function<void (void)> func);

typedef std::shared_ptr<class Activity> ActivityRef;

class Activity : public std::enable_shared_from_this<Activity> {
public:
    static ActivityRef create(const std::string reason);

    void begin();
    void end();

    std::string getReason() const { return mReason; }

private:
    Activity(const std::string reason) : mReason(reason) {}

    void* mActivity;
    std::string mReason;
};

}}
