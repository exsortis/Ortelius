//
//  ORTObjectMapping.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import "ORTObjectMapping.h"


@implementation ORTObjectMapping {

    @private
    NSMutableDictionary* _propertySourceMap;
    NSMutableDictionary* _propertyDestMap;
}

- (id)init {
    self = [super init];
    if(self) {
        _propertySourceMap = [NSMutableDictionary new];
        _propertyDestMap = [NSMutableDictionary new];
    }

    return self;
}

- (void)addPropertyMapping:(ORTPropertyMapping*)propertyMapping {

    _propertySourceMap[propertyMapping.sourceName] = propertyMapping;
    _propertyDestMap[propertyMapping.destName] = propertyMapping;
}

- (void)addPropertyMappings:(NSArray*)propertyMappings {

    for(ORTPropertyMapping* mapping in propertyMappings) {
        [self addPropertyMapping:mapping];
    }
}

- (ORTPropertyMapping*)propertyMappingForSourcePropertyName:(NSString*)propertyName {
    return _propertySourceMap[propertyName];
}

- (ORTPropertyMapping*)propertyMappingForDestinationPropertyName:(NSString*)propertyName {
    return _propertyDestMap[propertyName];
}

@end
