//
//  FDCanvasView.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//  This file is part of FrozenDraw(c).  FrozenDraw(c) is licenced under the MIT License.
//  See http://opensource.org/licenses/MIT for detailed information.
//
//	The reference to FrozenDraw(c) is appreciated but not required in your own product.
//	While the source code is licensed under the MIT License, that license doesn't cover the product's name.
//	You may not release your product under names "FrozenDraw" or "Frozen Draw".
//
//  Copyright (c) 2016 Ilya Vinogradov. All rights reserved.
//

#import "FDCanvasView.h"

@implementation FDCanvasView {
	CAShapeLayer * _currentLayer;
	int	_strokeCount;
}

#pragma mark - Initialization

- (instancetype)init {
	
	if (self = [super init]) {
		[self _setup];
	}
	return self;
}

- (void) awakeFromNib {
	[super awakeFromNib];
	[self _setup];
}

- (void) _setup {
	_strokeCount = 0;
}

#pragma mark - Drawing methods
 
-(void)beginNewStroke {
	_currentLayer= [CAShapeLayer layer];			// create new layer for drawing
	[self.layer addSublayer:_currentLayer];			// Add current layer as drawing sublayer
	_strokeCount++;
}

-(void)updateStrokeWithDrawingPath:(FDDrawingPath *) drawingPath {
	_currentLayer.strokeColor = drawingPath.pathColor.CGColor;
	_currentLayer.path = drawingPath.CGPath;
	_currentLayer.lineWidth = drawingPath.lineWidth;
}

-(void)removeCurrentStroke {
	[_currentLayer removeFromSuperlayer];
	_currentLayer = nil;
	_strokeCount--;
}

-(void)removeLastStroke {
	if (_currentLayer) {
		[self removeCurrentStroke];
	} else {
		[self.layer.sublayers.lastObject removeFromSuperlayer];
		_strokeCount--;
	}
}

- (void)clearCanvas {
	while (_strokeCount > 0) {
		[self removeLastStroke];
	}
}

@end
