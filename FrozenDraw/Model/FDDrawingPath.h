//
//  FDDrawingPath.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import <UIKit/UIKit.h>

@interface FDDrawingPath : UIBezierPath

@property (nonatomic, readonly) CGPoint lastTouchedPoint;
@property (nonatomic, readonly) UIColor * pathColor;

-(void) drawLineToPoint:(CGPoint) point;
-(instancetype) initWithColor:(UIColor *) color;

@end
