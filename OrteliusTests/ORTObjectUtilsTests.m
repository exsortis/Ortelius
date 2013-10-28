//
//  ORTObjectUtilsTests.m
//  Ortelius
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ORTTestSourceObject.h"

#import "ORTObjectUtils.h"


@interface ORTObjectUtilsTests : XCTestCase

@end

@implementation ORTObjectUtilsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPropertiesForClass {

    NSDictionary* props = [ORTObjectUtils propertiesForClass:[ORTTestSourceObject class]];
    XCTAssertTrue([[props allValues] count] >= 3, @"Test source object should have at least 3 properties");

    for(ORTPropertyAttributes* attrs in [props allValues]) {
        if([attrs.name isEqualToString:@"integerValue"]) {
            XCTAssertTrue(attrs.readOnly, @"Read-only for 'integerValue' should be YES");
        }
    }
}

- (void)testAttributesForPropertyName {

    ORTPropertyAttributes* attrs = [ORTObjectUtils attributesForPropertyName:@"stringValue"
                                    inClass:[ORTTestSourceObject class]];
    XCTAssertNotNil(attrs, @"Should have gotten attributes for 'stringValue' property of test source object");
    XCTAssertTrue(attrs.type == ORTPropertyTypeObject, @"Property type for 'stringValue' should be object");
    XCTAssertTrue(attrs.readOnly == NO, @"Read-only for 'stringValue' should be NO");
    XCTAssertNotNil(attrs.className, @"Class name should be set for 'stringValue'");
}

- (void)testAttributesForProperty {

    NSString* propertyName = @"booleanValue";
    const char* name = [propertyName cStringUsingEncoding:NSUTF8StringEncoding];
    objc_property_t property = class_getProperty([ORTTestSourceObject class], name);

    ORTPropertyAttributes* attrs = [ORTObjectUtils attributesForProperty:property];
    XCTAssertNotNil(attrs, @"Should have gotten attributes for 'booleanValue' property of test source object");
    XCTAssertTrue(attrs.type == ORTPropertyTypePrimitive, @"Property type for 'booleanValue' should be primitive");
    XCTAssertNil(attrs.className, @"Class name should NOT be set for 'booleanValue'");
}

@end
