//
//  FDCanvas.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import "FDCanvas.h"

@implementation FDCanvas

- (instancetype) init {
	if (self=[super init]) {
		_colorsWithDrawingPaths = [NSMutableDictionary new];
	}
	
	return self;
}

- (FDDrawingPath*) drawingPathForColor:(UIColor *)color {
	FDDrawingPath * drawingPath = _colorsWithDrawingPaths[color];
	if (!drawingPath) {
		drawingPath = [FDDrawingPath new];
		_colorsWithDrawingPaths[color] = drawingPath;
	}
	
	return drawingPath;
}

@end
