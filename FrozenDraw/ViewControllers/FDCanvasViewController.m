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

/*! @brief The canvas model object - contains a collection of drawing pathes necessary to making a stroke on the canvas view. */
@property (nonatomic, readonly) FDCanvas *canvas;
@end

// Size if the side of the square color button
static const CGFloat kButtonDimension = 30.0;

@implementation FDCanvasViewController {
	CAShapeLayer *_currentLayer;
}

#pragma mark - VC Lifecycle

- (void)viewDidLoad {
	_canvas = [FDCanvas new];
	_selectedColor = [UIColor blackColor];
	
	// Make a square for the color buton
	UIView * buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kButtonDimension, kButtonDimension)];
	
	_colorButton.image = [UIImage imageWithView:buttonBackgroundView];
	_colorButton.tintColor = _selectedColor;
}

#pragma mark - Target Actions

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
	
	CGPoint translation, destination;
	
	//get last path from model
	FDDrawingPath *drawingPath;
	
	switch (sender.state) {
		case UIGestureRecognizerStateBegan: {
			//Start new path
			drawingPath = [[FDDrawingPath alloc] initWithColor:_selectedColor];
			[drawingPath moveToPoint:[sender locationInView:_canvasView]];
			
			//Update model with new path
			[_canvas.strokes addObject:drawingPath];
			
			//Update view with new stroke
			[_canvasView beginNewStroke];
			
			break;
		}
		case UIGestureRecognizerStateChanged: //fall through
		case UIGestureRecognizerStateEnded: {
			//get last path from model
			drawingPath = [_canvas.strokes lastObject];
			
			//get cumulative distance
			translation = [sender translationInView:_canvasView];
			
			//calculate end point
			destination = [self _getDestinationPointForStartingPoint:drawingPath.lastTouchedPoint andTranslation:translation];
			
			//update canvas model
			[drawingPath drawLineToPoint:destination];
			
			//update stroke of canvas view with current drawing path
			[_canvasView updateStrokeWithDrawingPath:drawingPath];
			
			[sender setTranslation:CGPointZero inView:_canvasView];
			break;
		}
			
		case UIGestureRecognizerStateFailed:		//fall through
		case UIGestureRecognizerStateCancelled:
			//Gesture got canceled due to external even (PN, phone call) - undo it
			[_canvasView removeCurrentStroke];
			[_canvas.strokes removeLastObject];
			break;
		default:
			break;
	}
}

- (IBAction)clearCanvas:(UIBarButtonItem *)sender {
	[_canvas.strokes removeAllObjects];
	[_canvasView clearCanvas];
}

#pragma mark - Delegate Callbacks

-(void)newColorPicked:(UIColor *)pickedColor {
	_selectedColor = pickedColor;
	_colorButton.tintColor = pickedColor;
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	 ((FDColorPickerCollectionViewController *)[segue destinationViewController]).delegate = self;
 }
						  
#pragma mark - Auxiliary Methods

/*! 
 *	@brief Computes the end coordinate of the mouse movement given the starting coordinate and translation.
 *	@param startingPoint represents the starting coordinate of the mouse movment.
 *	@param translation represents the (X, Y) offeset from the starting point.
 *	@return end coordinate of the mouse movement given the translation.
 */
- (CGPoint)_getDestinationPointForStartingPoint:(CGPoint)startingPoint andTranslation: (CGPoint)translation {
	return CGPointMake(startingPoint.x + translation.x, startingPoint.y + translation.y);
}

@end


