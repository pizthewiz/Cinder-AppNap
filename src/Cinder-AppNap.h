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

void PerformActivity(const std::string& reason, const std::function<void (void)>& func);
void BeginActivity(const std::string& reason);
void EndActivity();

}}
