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
		_strokes = [NSMutableArray new];
	}
	return self;
}

@end
