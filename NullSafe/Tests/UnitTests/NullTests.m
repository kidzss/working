//
//  NullTests.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import <XCTest/XCTest.h>

#pragma clang diagnostic ignored "-Wobjc-messaging-id"

@implementation NSData (NullTests)

- (double)NullTestMethod
{
    return 47.6;
}

@end


@interface NullTests : XCTestCase

@end


@implementation NullTests

- (void)testStringValue
{
    id nullValue = [NSNull null];
    id result = [nullValue testAnyFunc:nullValue];
    XCTAssertNil(result);
}

- (id)testAnyFunc:(id)sender {
    id nullValue = [NSNull null];
    return @[nullValue,sender];
}

- (void)testFloatValue
{
    id nullValue = [NSNull null];
    __unused float x = floorf(123.456f); // makes sure compiler doesn't trick us
    float result = [nullValue floatValue];
    XCTAssertEqualWithAccuracy(result, 0.0f, 0.0f);
}

- (void)testIntValue
{
    id nullValue = [NSNull null];
    int result = [nullValue intValue];
    XCTAssertEqual(result, 0);
}

- (void)testPointerValue
{
    id nullValue = [NSNull null];
    const void *result = [nullValue bytes];
    XCTAssertNil((__bridge id)result);
}

- (void)testClass
{
    id nullValue = [NSNull null];
    NSString *result = NSStringFromClass([nullValue class]);
    XCTAssertEqualObjects(result, @"NSNull");
}

- (void)testDescription
{
    id nullValue = [NSNull null];
    NSString *result = [nullValue description];
    XCTAssertEqualObjects(result, @"<null>");
}

- (void)testCategory
{
    id nullValue = [NSNull null];
    __unused double x = floor(123.456);
    double result = [nullValue NullTestMethod];
    XCTAssertEqualWithAccuracy(result, 0.0, 0.0);
}

@end
