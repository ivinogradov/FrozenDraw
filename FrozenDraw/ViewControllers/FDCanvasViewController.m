//
//  FDCanvasViewController.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import "FDCanvasViewController.h"
#import "FDCanvas.h"

@interface FDCanvasViewController ()
@property (nonatomic, readonly) FDCanvas *canvas;
@end

@implementation FDCanvasViewController

- (void)viewDidLoad {
	_canvas = [FDCanvas new];
	_selectedColor = [UIColor blackColor];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
	
	CGPoint translation, destination;
	
	//get path from model
	FDDrawingPath *drawingPath = [_canvas drawingPathForColor:_selectedColor];
	
	switch (sender.state) {
		case UIGestureRecognizerStateBegan:
			//_canvasView.startingPoint = [sender locationInView:_canvasView];
			[drawingPath moveToPoint:[sender locationInView:_canvasView]];
			break;
			
		case UIGestureRecognizerStateChanged: //fall through
		case UIGestureRecognizerStateEnded:
			//get cumulative distance
			translation = [sender translationInView:_canvasView];
			//calculate end point
			destination = [self _getDestinationPointForStartingPoint:drawingPath.lastTouchedPoint andTranslation:translation];
			
			//update canvas model
			[drawingPath drawLineToPoint:destination];
			
			//update canvas view
			//_canvasView.drawPath = drawingPath;
			//[_canvasView drawLineToPoint:destination];
			[_canvasView reflectCanvas:_canvas];
			
			[sender setTranslation:CGPointZero inView:_canvasView];				//reset cumulative distance to zero
			break;
			
		default:
			break;
	}
}

- (IBAction)clearCanvas:(UIBarButtonItem *)sender {
	[_canvas.colorsWithDrawingPaths removeAllObjects];
	[_canvasView reflectCanvas:_canvas];
	_selectedColor = [UIColor blackColor];
}

- (IBAction)selectColor:(UIBarButtonItem *)sender {
	_selectedColor = [UIColor greenColor];
	//_canvasView.currentColor = _selectedColor;
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
