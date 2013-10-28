//
//  ORTObjectUtils.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORTPropertyAttributes.h"
#import <objc/runtime.h>


@interface ORTObjectUtils : NSObject

+ (NSDictionary*)propertiesForClass:(Class)objectClass;

+ (ORTPropertyAttributes*)attributesForPropertyName:(NSString*)propertyName
                                            inClass:(Class)objectClass;
+ (ORTPropertyAttributes*)attributesForProperty:(objc_property_t)property;

@end
