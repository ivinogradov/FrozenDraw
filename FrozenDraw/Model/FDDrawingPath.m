//
//  FDDrawingPath.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import "FDDrawingPath.h"

@implementation FDDrawingPath

static const CGFloat kDefaultLineWidth = 2.0;

-(instancetype) initWithColor:(UIColor *) color {
	return [self initWithColor:color andWidth:kDefaultLineWidth];
}

//designated initializer
-(instancetype) initWithColor:(UIColor *)color andWidth:(CGFloat) width {
	if (self = [super init]) {
		_pathColor = color;
		self.lineWidth = width;
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
