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

#pragma mark - VC Lifecycle

- (void)viewDidLoad {
	_canvas = [FDCanvas new];
	_selectedColor = [UIColor blackColor];
	
	// Make a square for the color buton
	UIView * buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
	
	_colorButton.image = [UIImage imageWithView:buttonBackgroundView];
	_colorButton.tintColor = _selectedColor;
}

#pragma mark - Target Actions

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
	
	CGPoint translation, destination;
	
	//get path from model
	FDDrawingPath *drawingPath = [_canvas drawingPathForColor:_selectedColor];
	
	switch (sender.state) {
		case UIGestureRecognizerStateBegan:
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
			[_canvasView reflectCanvas:_canvas];
			
			//reset cumulative distance to zero
			[sender setTranslation:CGPointZero inView:_canvasView];
			break;
			
		default:
			break;
	}
}

- (IBAction)clearCanvas:(UIBarButtonItem *)sender {
	[_canvas.colorsWithDrawingPaths removeAllObjects];
	[_canvasView reflectCanvas:_canvas];
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
- (CGPoint)_getDestinationPointForStartingPoint:(CGPoint)startingPoint andTranslation: (CGPoint)translation {
	return CGPointMake(startingPoint.x + translation.x, startingPoint.y + translation.y);
}

@end

@implementation UIImage (ViewConverter)
//FIXME: Move to UIImage+ViewConverter.h
+ (UIImage *) imageWithView:(UIView *) view {
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
