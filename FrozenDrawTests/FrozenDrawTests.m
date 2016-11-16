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
	
	//Test with empty drawing path
	[canvasView updateStrokeWithDrawingPath:[FDDrawingPath new]];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers + 1);
	
	[canvasView removeCurrentStroke];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers);
}

- (void)testCanvasViewClear {
	FDCanvasView * canvasView = [[FDCanvasView alloc] init];
	NSUInteger clearLayers = canvasView.layer.sublayers.count;
	
	FDDrawingPath * path;
	int totalStrokeCount = 1000;
	int pointsX = 1920;
	int pointsY = 800;
	int maxLineWidth = 8;
	
	for (int i = 1; i < totalStrokeCount; i++) {
		[canvasView beginNewStroke];
		XCTAssert(canvasView.layer.sublayers.count == clearLayers + i);
		
		// black line with width random width in range [1..8]
		path = [[FDDrawingPath alloc] initWithColor:[UIColor blackColor] andWidth:arc4random_uniform(maxLineWidth)+1.0];
		
		// from a random position on the screen to a random position
		[path moveToPoint:CGPointMake((CGFloat)arc4random_uniform(pointsX),(CGFloat)arc4random_uniform(pointsY))];
		[path drawLineToPoint:CGPointMake((CGFloat)arc4random_uniform(pointsX),(CGFloat)arc4random_uniform(pointsY))];
		
		[canvasView updateStrokeWithDrawingPath:[FDDrawingPath new]];
		XCTAssert(canvasView.layer.sublayers.count == clearLayers + i);
	}
	
	[canvasView clearCanvas];
	XCTAssert(canvasView.layer.sublayers.count == clearLayers);
	
}

@end
