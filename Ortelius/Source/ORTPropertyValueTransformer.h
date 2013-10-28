//
//  ORTPropertyValueTransformer.h
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ORTPropertyValueTransformer <NSObject>

- (id)transformFrom:(id)fromValue;

@end
