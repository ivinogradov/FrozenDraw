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

@implementation FDCanvasViewController {
	CAShapeLayer *currentLayer;
}

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
	
	//get last path from model
	FDDrawingPath *drawingPath;
	//CAShapeLayer *currentLayer;
	
	switch (sender.state) {
		case UIGestureRecognizerStateBegan: {
			//Update model - start new path
			drawingPath = [[FDDrawingPath alloc] initWithColor:_selectedColor];
			[drawingPath moveToPoint:[sender locationInView:_canvasView]];
			[_canvas.strokes addObject:drawingPath];
			
			//Update view
			CAShapeLayer * layer = (CAShapeLayer *)_canvasView.layer; // get main layer in canvas view
			currentLayer  = [CAShapeLayer layer];					  // create new layer for drawing
			[layer addSublayer:currentLayer];						  // Add current layer as drawing sublayer
			
			break;
		}
		case UIGestureRecognizerStateChanged: //fall through
		case UIGestureRecognizerStateEnded: {
			drawingPath = [_canvas.strokes lastObject];		  //FIXME: replace with linked list if available
			//get cumulative distance
			translation = [sender translationInView:_canvasView];
			//calculate end point
			destination = [self _getDestinationPointForStartingPoint:drawingPath.lastTouchedPoint andTranslation:translation];
			
			//update canvas model
			[drawingPath drawLineToPoint:destination];
			
			//update drawing layer of canvas view with current drawing path
			currentLayer.strokeColor = drawingPath.pathColor.CGColor;
			currentLayer.path = drawingPath.CGPath;
			currentLayer.lineWidth = 5.0;

			/*
			if (sender.state == UIGestureRecognizerStateEnded) {
				//finalize the drawing and add it as sublayer
				//currentLayer = [layer copy];
				//layer = nil;
				currentLayer.strokeColor=drawingPath.pathColor.CGColor;
				currentLayer.path = drawingPath.CGPath;
				currentLayer.lineWidth = 2.0;
				
				
				layer.path = nil;
			}
			*/
			//reset cumulative distance to zero
			[sender setTranslation:CGPointZero inView:_canvasView];
			break;
		}
			
		case UIGestureRecognizerStateFailed:		//fall through
		case UIGestureRecognizerStateCancelled:
			[currentLayer removeFromSuperlayer];
			break;
		default:
			break;
	}
}

- (IBAction)clearCanvas:(UIBarButtonItem *)sender {
	for (int i =0; i < _canvas.strokes.count; i++) {
		CALayer *layer = [[_canvasView.layer sublayers] lastObject];
		[layer removeFromSuperlayer];
	}
	[_canvas.strokes removeAllObjects];
	//[_canvasView reflectCanvas:_canvas];
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
