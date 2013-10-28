//
//  ORTErrors.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import "ORTErrors.h"


@implementation ORTErrors

- (id)init {
    self = [super init];
    if(self) {
        _errors = [NSArray new];
    }

    return self;
}

- (void)addError:(NSError*)error {
    _errors = [_errors arrayByAddingObject:error];
}

@end
