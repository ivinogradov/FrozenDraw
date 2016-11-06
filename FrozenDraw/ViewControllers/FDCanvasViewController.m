//
//  FDCanvasViewController.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import "FDCanvasViewController.h"

@interface FDCanvasViewController ()

@end

@implementation FDCanvasViewController

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
	
	CGPoint translation, destination;
	
	switch (sender.state) {
		case UIGestureRecognizerStateBegan:
			_canvasView.startingPoint = [sender locationInView:_canvasView];
			break;
			
		case UIGestureRecognizerStateChanged: //fall through
		case UIGestureRecognizerStateEnded:
			//get cumulative distance
			translation = [sender translationInView:_canvasView];
			//calculate end point
			destination = [self _getDestinationPointForStartingPoint:_canvasView.startingPoint andTranslation:translation];
			[_canvasView drawLineToPoint:destination];
			
			[sender setTranslation:CGPointZero inView:_canvasView];				//reset cumulative distance to zero
			break;
			
		default:
			break;
	}
}

- (IBAction)clearCanvas:(UIBarButtonItem *)sender {
	[_canvasView clearCanvas];
}


- (CGPoint)_getDestinationPointForStartingPoint:(CGPoint)startingPoint andTranslation: (CGPoint)translation {
	return CGPointMake(startingPoint.x + translation.x, startingPoint.y + translation.y);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
