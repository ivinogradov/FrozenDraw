//
//  FDCanvasView.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
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
