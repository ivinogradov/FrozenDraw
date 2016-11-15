//
//  FrozenDrawTests.m
//  FrozenDrawTests
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import <XCTest/XCTest.h>
#import "FDCanvasView.h"
#import "FDDrawingPath.h"
@interface FrozenDrawTests : XCTestCase

@end

@implementation FrozenDrawTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCanvasViewOneLayer {
	
	FDCanvasView * canvasView = [[FDCanvasView alloc] init];
	NSUInteger clearLayers = canvasView.layer.sublayers.count;
	
	[canvasView beginNewStroke];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers + 1);
	
	[canvasView updateStrokeWithDrawingPath:[FDDrawingPath new]];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers + 1);
	
	[canvasView removeCurrentStroke];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers);
}

- (void)testCanvasViewClear {
	FDCanvasView * canvasView = [[FDCanvasView alloc] init];
	NSUInteger clearLayers = canvasView.layer.sublayers.count;
	
	for (int i = 1; i < 1000; i++) {
		[canvasView beginNewStroke];
		XCTAssert(canvasView.layer.sublayers.count == clearLayers + i);
		
		[canvasView updateStrokeWithDrawingPath:[FDDrawingPath new]];
		XCTAssert(canvasView.layer.sublayers.count == clearLayers + i);
	}
	
	[canvasView clearCanvas];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers);
	
}

@end
