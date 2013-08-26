//
//  PropertiesViewController.h
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ColorPickerViewController.h"
#import "FontSelectionController.h"

@interface PropertiesViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,ColorPickerViewControllerDelegate,FontSelectionControllerDelegate> {
	IBOutlet UITextField *textFieldFontName;
	IBOutlet UIView *viewFontColor;
	IBOutlet UITextField *textFieldFontSize;
	IBOutlet UIView *view1;
	IBOutlet UIView *view2;
	IBOutlet UIView *view3;
	
	NSArray *sizeArray;
	NSMutableDictionary *dataDictionary;
	
	/**variables for pickerview in actionsheet **/
	UIActionSheet *actionSheet;
	UIPickerView *pickerForFontSize;
	
}
@property(assign)NSMutableDictionary *dataDictionary;
-(IBAction)selectFontName:(id)Sender;
-(IBAction)selectFontColor:(id)sender;
-(IBAction)selectFontSize:(id)Sender;
-(void)dismissActionSheet:(id)sender;
@end
