//
//  FDColorPickerCollectionViewController.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/10/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol FDColorPickerDelegate
//TODO: documentation
-(void) newColorPicked:(UIColor *) pickedColor;
@end


@interface FDColorPickerCollectionViewController : UICollectionViewController
@property (nonatomic, weak) id<FDColorPickerDelegate> delegate;
@end

