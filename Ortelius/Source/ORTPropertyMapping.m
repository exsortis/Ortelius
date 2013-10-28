//
//  ORTPropertyMapping.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import "ORTPropertyMapping.h"

#import "ORTPropertyAttributes.h"

#import "ORTObjectUtils.h"


@implementation ORTPropertyMapping

+ (ORTPropertyMapping*)mappingForObject:(id)sourceObject
                           propertyName:(NSString*)propertyName
                               toObject:(id)destObject {

    ORTPropertyAttributes* sourceAttrs = [ORTObjectUtils attributesForPropertyName:propertyName
                                                                           inClass:[sourceObject class]];
    ORTPropertyAttributes* destAttrs = [ORTObjectUtils attributesForPropertyName:propertyName
                                                                         inClass:[destObject class]];

    if(sourceAttrs == nil ||
       destAttrs == nil) {
        // Couldn't find either source or destination attributes for the property, so give up.
        NSLog(@"Couldn't find either source or destination property for '%@'; giving up.", propertyName);
        return nil;
    }

    ORTPropertyMapping* mapping = [ORTPropertyMapping new];

    mapping.sourceName = propertyName;
    mapping.destName = propertyName;
    
    // TODO
    
    return mapping;
}

@end
