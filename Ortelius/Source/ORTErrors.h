//
//  ORTErrors.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ORTErrors : NSObject

@property (nonatomic, readonly) NSArray* errors;

- (void)addError:(NSError*)error;

@end
