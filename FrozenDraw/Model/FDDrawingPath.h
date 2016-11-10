//
//  FDDrawingPath.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import <UIKit/UIKit.h>

@interface FDDrawingPath : UIBezierPath
@property (nonatomic) CGPoint lastTouchedPoint;

-(void) drawLineToPoint:(CGPoint) point;

@end
