//
//  FDDrawingPath.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
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

#import "FDDrawingPath.h"

@implementation FDDrawingPath

static const CGFloat kDefaultLineWidth = 2.0;

-(instancetype) initWithColor:(UIColor *) color {
	return [self initWithColor:color andWidth:kDefaultLineWidth];
}

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
