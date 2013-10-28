//
//  ORTObjectMapping.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORTPropertyMapping.h"


@interface ORTObjectMapping : NSObject

@property (nonatomic, assign) Class sourceClass;
@property (nonatomic, assign) Class destClass;

- (void)addPropertyMapping:(ORTPropertyMapping*)propertyMapping;
- (void)addPropertyMappings:(NSArray*)propertyMappings;

- (ORTPropertyMapping*)propertyMappingForSourcePropertyName:(NSString*)propertyName;
- (ORTPropertyMapping*)propertyMappingForDestinationPropertyName:(NSString*)propertyName;

@end
