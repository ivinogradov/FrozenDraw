//
//  FDDrawingPath.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import "FDDrawingPath.h"

@implementation FDDrawingPath

-(instancetype) initWithColor:(UIColor *) color {
	if (self = [super init]) {
		_pathColor = color;
	}
	return self;
}

-(void) moveToPoint:(CGPoint)point {
	[super moveToPoint:point];
	_lastTouchedPoint = point;
}

-(void) drawLineToPoint:(CGPoint) point {
	[self addLineToPoint:point];
	[self moveToPoint:point];
}

@end
