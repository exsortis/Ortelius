//
//  OrteliusTests.m
//  OrteliusTests
//
//  Created by Paul Schifferer on 10/27/13.
//  Copyright (c) 2013 Pilgrimage Software. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ORTTestSourceObject.h"
#import "ORTTestDestObject.h"
#import "ORTTestOtherObject.h"

#import "ORTObjectMapper.h"


@interface ORTMappingTests : XCTestCase

@end

@implementation ORTMappingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectToObjectMap {

    ORTTestSourceObject* source = [[ORTTestSourceObject alloc] initWithIntegerValue:2];
    source.stringValue = @"string1";
    source.booleanValue = YES;

    ORTTestDestObject* dest = [[ORTTestDestObject alloc] initWithIntegerValue:7];

    ORTObjectMapping* mapping = [[ORTObjectMapping alloc] init];
    mapping.sourceClass = [ORTTestSourceObject class];
    mapping.destClass = [ORTTestDestObject class];

    ORTObjectMapper* mapper = [[ORTObjectMapper alloc] initWithMapping:mapping];

    ORTErrors* errors = [ORTErrors new];
    BOOL success = [mapper mapObject:source
                            toObject:dest
                              errors:errors];

    XCTAssertTrue(success, @"Mapping should have been successful");
    XCTAssertTrue([dest.stringValue isEqualToString:@"string1"], @"Destination object's 'stringValue' property should be set to 'string1'");
    XCTAssertTrue(dest.integerValue == 7, @"Destination object's 'integerValue' should be 7");
}

- (void)testPropertyMapping {

    ORTTestSourceObject* source = [[ORTTestSourceObject alloc] initWithIntegerValue:99];
    source.stringValue = @"string3";
    source.booleanValue = YES;

    ORTObjectMapping* mapping = [[ORTObjectMapping alloc] init];
    mapping.sourceClass = [ORTTestSourceObject class];
    mapping.destClass = [ORTTestOtherObject class];

    ORTPropertyMapping* propertyMap = [ORTPropertyMapping new];
    propertyMap.sourceName = @"stringValue";
    propertyMap.destName = @"nameValue";
    [mapping addPropertyMapping:propertyMap];

    ORTObjectMapper* mapper = [[ORTObjectMapper alloc] initWithMapping:mapping];

    ORTErrors* errors = [ORTErrors new];
    ORTTestOtherObject* dest = [mapper mapObject:source
                                          errors:errors];

    XCTAssertNotNil(dest, @"Mapped destination object should not be nil");
    XCTAssertTrue([dest.nameValue isEqualToString:@"string3"], @"Destination object's 'nameValue' property should be 'string3'");
}

- (void)testIncompatiblePropertyMapping {

    ORTTestSourceObject* source = [[ORTTestSourceObject alloc] initWithIntegerValue:86];
    source.stringValue = @"string4";

    ORTObjectMapping* mapping = [[ORTObjectMapping alloc] init];
    mapping.sourceClass = [ORTTestSourceObject class];
    mapping.destClass = [ORTTestOtherObject class];

    ORTPropertyMapping* propertyMap = [ORTPropertyMapping new];
    propertyMap.sourceName = @"booleanValue";
    propertyMap.destName = @"nameValue";
    [mapping addPropertyMapping:propertyMap];

    ORTObjectMapper* mapper = [[ORTObjectMapper alloc] initWithMapping:mapping];

    ORTTestOtherObject* dest = [ORTTestOtherObject new];
    dest.nameValue = @"originalValue";

    ORTErrors* errors = [ORTErrors new];
    BOOL success = [mapper mapObject:source
                            toObject:dest
                              errors:errors];

    XCTAssertTrue(success, @"Mapping should have been successful");
    XCTAssertTrue([[errors errors] count] > 0, @"There should be errors from the mapping");
    XCTAssertTrue([dest.nameValue isEqualToString:@"originalValue"], @"Destination object's 'nameValue' should still be 'originalValue'");
}

- (void)testObjectToClassMap {

    ORTTestSourceObject* source = [[ORTTestSourceObject alloc] initWithIntegerValue:42];
    source.stringValue = @"string2";

    ORTObjectMapping* mapping = [[ORTObjectMapping alloc] init];
    mapping.sourceClass = [ORTTestSourceObject class];
    mapping.destClass = [ORTTestDestObject class];

    ORTObjectMapper* mapper = [[ORTObjectMapper alloc] initWithMapping:mapping];

    ORTErrors* errors = [ORTErrors new];
    ORTTestDestObject* dest = [mapper mapObject:source
                                         errors:errors];

    XCTAssertNotNil(dest, @"Mapped destination object should not be nil");
    XCTAssertTrue([dest.stringValue isEqualToString:@"string2"], @"Destination object's 'stringValue' property should be set to 'string2'");
    XCTAssertTrue(dest.integerValue == 0, @"Destination object's 'integerValue' should be 0");
}

- (void)testObjectToJSONMap {
    
    ORTTestSourceObject* source = [[ORTTestSourceObject alloc] initWithIntegerValue:2];
    source.stringValue = @"string1";
    source.booleanValue = YES;

    ORTObjectMapper* mapper = [ORTObjectMapper new];

    ORTErrors* errors = [ORTErrors new];
    NSDictionary* json = [mapper mapObjectToJSON:source
                                          errors:errors];

    XCTAssertNotNil(json, @"Destination JSON dictionary should not be nil");
    XCTAssertTrue([json[@"stringValue"] isEqualToString:@"string1"], @"Destination JSON dictionary's 'stringValue' entry should be 'string1'");
    XCTAssertTrue([json[@"integerValue"] integerValue] == 2, @"Destination JSON dictionary's 'integerValue' entry should be 2");
    XCTAssertTrue([json[@"booleanValue"] boolValue] == YES, @"Destination JSON dictionary's 'booleanValue' entry should be YES");
}

@end
