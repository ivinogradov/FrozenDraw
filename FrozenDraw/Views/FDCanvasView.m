//
//  FDCanvasView.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import "FDCanvasView.h"

typedef enum {
	FDDrawingModeDrawing,
	FDDrawingModeClearing
} FDDrawingMode;

@implementation FDCanvasView {
	UIBezierPath *_drawPath;
	FDDrawingMode _drawingMode;
}


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
	_drawPath = [UIBezierPath new];
	_drawingMode = FDDrawingModeDrawing;
}

#pragma mark - Drawing methods

- (void)drawLineToPoint:(CGPoint) point {
	[_drawPath addLineToPoint:point];
	[self setStartingPoint:point];
	[self setNeedsDisplay];
}

- (void)setStartingPoint:(CGPoint)startingPoint {
	_startingPoint = startingPoint;
	[_drawPath moveToPoint:startingPoint];
}

- (void)clearCanvas {
	//_drawingMode = FDDrawingModeClearing;
	[self _setup];
	[self setNeedsDisplay];
}

// All drawing/clearing happens here
- (void)drawRect:(CGRect)rect {
	
	if (_drawingMode == FDDrawingModeDrawing) {
		[[UIColor magentaColor] setStroke];
		[_drawPath stroke];
	} else {					// clearing
		//CGContextRef context = UIGraphicsGetCurrentContext();
		//CGContextSaveGState(context);
		[[UIColor whiteColor] setFill];
		UIRectFill(self.bounds);
		_drawingMode = FDDrawingModeDrawing;
		//CGContextRestoreGState(context);
		//[[UIColor blackColor] setStroke];
	}
}

@end
