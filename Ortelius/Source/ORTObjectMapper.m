//
//  ORTObjectMapper.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import "ORTObjectMapper.h"

#import "ORTObjectUtils.h"

#import "ORTConstants.h"


@implementation ORTObjectMapper

#pragma mark - Initialization

- (instancetype)initWithMapping:(ORTObjectMapping*)mapping {
    self = [super init];
    if(self) {
        _mapping = mapping;
    }

    return self;
}


#pragma mark - Public API

- (BOOL)mapObject:(id)sourceObject
         toObject:(id)destObject
           errors:(ORTErrors*)errors {

    // Sanity checks.
    NSAssert(sourceObject, @"Source object must be provided!");
    NSAssert(destObject, @"Destination object must be provided!");

    // Get properties for source object.
    NSDictionary* sourceProperties = [ORTObjectUtils propertiesForClass:[sourceObject class]];

    // Iterate over source properties.
    for(ORTPropertyAttributes* sourceProperty in [sourceProperties allValues]) {
        // Check for field for source property.
        ORTPropertyMapping* mapping = [_mapping propertyMappingForSourcePropertyName:sourceProperty.name];
        if(mapping == nil) {
            // No mapping, so try discovery...
            mapping = [ORTPropertyMapping mappingForObject:sourceObject
                                              propertyName:sourceProperty.name
                                                  toObject:destObject];
        }

        if(mapping == nil) {
            // No field info found, even after discovery, so skip it.
            if(errors) {
                NSError* error = [NSError errorWithDomain:ORTErrorDomain
                                                     code:ORTErrorMissingSourceProperty
                                                 userInfo:@{
                                                            ORTErrorPropertyNameKey : sourceProperty.name,
                                                            }];
                [errors addError:error];
            }
            NSLog(@"No property information for source property: %@; skipping.", sourceProperty.name);
            continue;
        }

        // See if there's a custom value transformer for this mapping.
        ORTPropertyAttributes* destProperty = [ORTObjectUtils attributesForPropertyName:mapping.destName
                                                                                inClass:[destObject class]];
        if(destProperty == nil) {
            if(errors) {
                NSError* error = [NSError errorWithDomain:ORTErrorDomain
                                                     code:ORTErrorMissingDestinationProperty
                                                 userInfo:@{
                                                            ORTErrorPropertyNameKey : mapping.destName,
                                                            }];
                [errors addError:error];
            }
            NSLog(@"No property information for destination property: %@; skipping.", mapping.destName);
            continue;
        }

        // Check for read-only property.
        if(destProperty.readOnly) {
            if(errors) {
                NSError* error = [NSError errorWithDomain:ORTErrorDomain
                                                     code:ORTErrorReadOnlyDestinationProperty
                                                 userInfo:@{
                                                            ORTErrorPropertyNameKey : mapping.destName,
                                                            }];
                [errors addError:error];
            }
            NSLog(@"Destination property is read-only: %@; skipping.", mapping.destName);
            continue;
        }

        if(mapping.valueTransformer) {
            id<ORTPropertyValueTransformer> transformer = mapping.valueTransformer;

            id fromValue = [sourceObject valueForKey:sourceProperty.name];
            id toValue = [transformer transformFrom:fromValue];
            [destObject setValue:toValue
                          forKey:mapping.destName];
        }
        else {
            // Check for compatiblity.
            if((sourceProperty.type == ORTPropertyTypePrimitive &&
                destProperty.type != ORTPropertyTypePrimitive) ||
               (sourceProperty.type != ORTPropertyTypePrimitive &&
                destProperty.type == ORTPropertyTypePrimitive)) {
                   if(errors) {
                       NSError* error = [NSError errorWithDomain:ORTErrorDomain
                                                            code:ORTErrorIncompatiblePropertyTypes
                                                        userInfo:@{
                                                                   ORTErrorPropertyNameKey : mapping.destName,
                                                                   }];
                       [errors addError:error];
                   }
                   NSLog(@"Source and destination properties are incompatible: %@; skipping", mapping.destName);
                   continue;
               }

            id fromValue = [sourceObject valueForKey:sourceProperty.name];
            [destObject setValue:fromValue
                          forKey:mapping.destName];
        }
    }

    return YES;
}

- (id)mapObject:(id)sourceObject
         errors:(ORTErrors*)errors {

    // Create a new destination object instance.
    id destObject = [_mapping.destClass new];

    BOOL success = [self mapObject:sourceObject
                          toObject:destObject
                            errors:errors];
    if(!success) {
        return nil;
    }

    return destObject;
}

- (NSDictionary*)mapObjectToJSON:(id)sourceObject
                          errors:(ORTErrors*)errors {

    // Sanity checks.
    NSAssert(sourceObject, @"Source object must be provided!");

    NSMutableDictionary* json = [NSMutableDictionary new];

    // Get properties for source object.
    NSDictionary* sourceProperties = [ORTObjectUtils propertiesForClass:[sourceObject class]];

    // Iterate over source properties.
    for(ORTPropertyAttributes* sourceProperty in [sourceProperties allValues]) {

        id value = [sourceObject valueForKey:sourceProperty.name];
        ORTPropertyMapping* mapping = [_mapping propertyMappingForSourcePropertyName:sourceProperty.name];

        if(sourceProperty.type == ORTPropertyTypePrimitive) {
            // Check for field for source property.
            if(mapping) {
                json[mapping.destName] = value;
            }
            else {
                if(sourceProperty.type == ORTPropertyTypePrimitive) {
                    json[sourceProperty.name] = value;
                }
            }
        }
        else {
            // Check for strings.
            if([value isKindOfClass:[NSString class]] ||
               [value isKindOfClass:[NSNumber class]]) {
                if(mapping) {
                    json[mapping.destName] = value;
                }
                else {
                    json[sourceProperty.name] = value;
                }
            }
            else {
                NSDictionary* subObject = [self mapObjectToJSON:value
                                                         errors:errors];
                if(subObject) {
                    if(mapping) {
                        json[mapping.destName] = subObject;
                    }
                    else {
                        json[sourceProperty.name] = subObject;
                    }
                }
            }
        }
    }
    
    return [json copy];
}

@end
