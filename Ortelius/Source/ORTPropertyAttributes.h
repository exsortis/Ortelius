//
//  ORTPropertyAttributes.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, ORTPropertyType) {
ORTPropertyTypeId,
    ORTPropertyTypeObject,
ORTPropertyTypePrimitive,
};

@interface ORTPropertyAttributes : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) ORTPropertyType type;
@property (nonatomic, copy) NSString* className;
@property (nonatomic, assign) BOOL readOnly;
@property (nonatomic, assign) BOOL dynamic;
@property (nonatomic, assign) BOOL nonAtomic;
@property (nonatomic, assign) BOOL weakReference;
@property (nonatomic, assign) BOOL strongReference;
@property (nonatomic, assign) BOOL copied;
@property (nonatomic, assign) SEL getter;
@property (nonatomic, assign) SEL setter;

@end
