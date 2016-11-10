//
//  FDCanvas.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FDDrawingPath.h"

@interface FDCanvas : NSObject

@property (nonatomic) NSMutableDictionary<UIColor *,FDDrawingPath *> *colorsWithDrawingPaths;

- (FDDrawingPath*) drawingPathForColor:(UIColor *)color;

@end
