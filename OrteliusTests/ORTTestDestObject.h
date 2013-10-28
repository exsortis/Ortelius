//
//  ORTTestDestObject.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ORTTestDestObject : NSObject

- (instancetype)initWithIntegerValue:(NSInteger)value;

@property (nonatomic, copy) NSString* stringValue;
@property (nonatomic, readonly) NSInteger integerValue;

@end
