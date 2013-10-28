//
//  ORTTestSourceObject.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ORTTestSourceObject : NSObject

- (instancetype)initWithIntegerValue:(NSInteger)value;

@property (nonatomic, copy) NSString* stringValue;
@property (nonatomic, assign) BOOL booleanValue;
@property (nonatomic, readonly) NSInteger integerValue;

@end
