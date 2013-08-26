//
//  ColorPickerViewController.h
//  CardSwap
//
//  Created by mac on 4/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorPickerViewController;

@protocol ColorPickerViewControllerDelegate <NSObject>

- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color;

@end

@interface ColorPickerViewController : UIViewController {
    id<ColorPickerViewControllerDelegate> delegate;
#ifdef IPHONE_COLOR_PICKER_SAVE_DEFAULT
    NSString *defaultsKey;
#else
    UIColor *defaultsColor;
#endif
    IBOutlet UIButton *chooseButton;
	IBOutlet UIButton *cancelButton;
}

// Use this member to update the display after the default color value
// was changed.
// This is required when e.g. the view controller is kept in memory
// and is re-used for another color value selection
// Automatically called after construction, so no need to do it here.
-(void) moveToDefault;


@property(nonatomic,assign)	id<ColorPickerViewControllerDelegate> delegate;
#ifdef IPHONE_COLOR_PICKER_SAVE_DEFAULT
@property(readwrite,nonatomic,retain) NSString *defaultsKey;
#else
@property(readwrite,nonatomic,retain) UIColor *defaultsColor;
#endif


- (IBAction) chooseSelectedColor;
- (IBAction) cancelColorSelection;
- (UIColor *) getSelectedColor;

@end

