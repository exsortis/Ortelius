//
//  ORTPropertyMapping.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORTPropertyValueTransformer.h"


typedef NS_ENUM(NSInteger, ORTPropertyMappingType) {
    ORTFieldTypeId,
    ORTFieldTypeObject,
    ORTFieldTypeBoolean,
    ORTFieldTypeInteger,
    ORTFieldTypeDouble,
    ORTFieldTypeFloat,
    ORTFieldTypeDate,
    ORTFieldTypeTimeInterval,
    ORTFieldTypeURL,
    ORTFieldTypeCustom,
};

@interface ORTPropertyMapping : NSObject

@property (nonatomic, copy) NSString* sourceName;
@property (nonatomic, copy) NSString* destName;
@property (nonatomic, assign) ORTPropertyMappingType type;
@property (nonatomic, weak) id<ORTPropertyValueTransformer> valueTransformer;

+ (ORTPropertyMapping*)mappingForObject:(id)sourceObject
                           propertyName:(NSString*)propertyName
                               toObject:(id)destObject;

@end
