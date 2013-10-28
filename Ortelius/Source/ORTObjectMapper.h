//
//  ORTObjectMapper.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORTObjectMapping.h"
#import "ORTErrors.h"


@interface ORTObjectMapper : NSObject

/**
 * Initialize a mapper.
 */
- (instancetype)initWithMapping:(ORTObjectMapping*)mapping;

/**
 */
@property (nonatomic, retain) ORTObjectMapping* mapping;

/**
 */
- (BOOL)mapObject:(id)sourceObject
       toObject:(id)destObject
            errors:(ORTErrors*)errors;
/**
 */
- (id)mapObject:(id)sourceObject
         errors:(ORTErrors*)errors;

/**
 */
- (NSDictionary*)mapObjectToJSON:(id)sourceObject
                          errors:(ORTErrors*)errors;

@end
