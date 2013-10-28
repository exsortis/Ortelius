//
//  ORTTestSourceObject.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import "ORTTestSourceObject.h"


@implementation ORTTestSourceObject

- (instancetype)initWithIntegerValue:(NSInteger)value {
    self = [super init];
    if(self) {
        _integerValue = value;
    }

    return self;
}

@end
