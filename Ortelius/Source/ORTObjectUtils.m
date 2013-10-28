//
//  ORTObjectUtils.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import "ORTObjectUtils.h"


@implementation ORTObjectUtils

+ (NSDictionary*)propertiesForClass:(Class)objectClass {

    NSMutableDictionary* propertyDict = [NSMutableDictionary new];

    unsigned int count = 0;
    objc_property_t* properties = class_copyPropertyList(objectClass, &count);
    for(int i = 0; i < count; i++) {
        objc_property_t property = properties[i];

        ORTPropertyAttributes* attrs = [ORTObjectUtils attributesForProperty:property];

        propertyDict[attrs.name] = attrs;
    }
    free(properties);

    return [propertyDict copy];
}

+ (ORTPropertyAttributes*)attributesForPropertyName:(NSString*)propertyName
                                            inClass:(Class)objectClass {

    const char* name = [propertyName cStringUsingEncoding:NSUTF8StringEncoding];
    objc_property_t property = class_getProperty(objectClass, name);

    if(property == NULL)
        return nil;

    return [self attributesForProperty:property];
}

+ (ORTPropertyAttributes*)attributesForProperty:(objc_property_t)property {

    ORTPropertyAttributes* attributes = [ORTPropertyAttributes new];

    const char* name = property_getName(property);
    attributes.name = [NSString stringWithCString:name
                                         encoding:NSUTF8StringEncoding];

    const char* attrs = property_getAttributes(property);
    NSString* attrsString = [NSString stringWithUTF8String:attrs];
    NSArray* comps = [attrsString componentsSeparatedByString:@","];
    for(NSString* comp in comps) {
        const char attrType = [comp characterAtIndex:0];
        switch(attrType) {
            case 'T': // encoded type
                [ORTObjectUtils populateAttribute:attributes
                                         withType:[comp substringFromIndex:1]];
                break;

            case 'R': // read-only
                attributes.readOnly = YES;
                break;

            case 'C': // copied
                attributes.copied = YES;
                break;

            case '&': // strong reference
                attributes.strongReference = YES;
                break;

            case 'N': // non-atomic
                attributes.nonAtomic = YES;
                break;

            case 'G': // getter
                attributes.getter = NSSelectorFromString([comp substringFromIndex:1]);
                break;

            case 'S': // setter
                attributes.setter = NSSelectorFromString([comp substringFromIndex:1]);
                break;

            case 'D': // dynamic
                attributes.dynamic = YES;
                break;

            case 'W': // weak
                attributes.weakReference = YES;
                break;

            default:
                break;
        }
    }

    return attributes;
}

+ (void)populateAttribute:(ORTPropertyAttributes*)attributes
                 withType:(NSString*)typeInfo {

    const char type = [typeInfo characterAtIndex:0];
    switch (type) {
        case 'c': // char
        case 'd': // double
        case 'i': // int
        case 'f': // float
        case 'l': // long
        case 's': // short
            attributes.type = ORTPropertyTypePrimitive;
            break;

        case '@': // id or class
            if([typeInfo length] > 1) {
                attributes.type = ORTPropertyTypeObject;
                attributes.className = [typeInfo substringFromIndex:1];
            }
            else {
                attributes.type = ORTPropertyTypeId;
            }
            break;
    }
}

@end
