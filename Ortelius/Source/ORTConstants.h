//
//  ORTConstants.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const ORTErrorDomain;

typedef NS_ENUM(NSInteger, ORTError) {
    ORTErrorMissingSourceProperty,
    ORTErrorMissingDestinationProperty,
    ORTErrorReadOnlyDestinationProperty,
    ORTErrorIncompatiblePropertyTypes,
};

extern NSString* const ORTErrorPropertyNameKey;
