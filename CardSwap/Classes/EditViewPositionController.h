//
//  EditViewPositionController.h
//  CardSwap
//
//  Created by mac on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ColorPickerViewController.h"
#import "DragLabel.h"


@interface EditViewPositionController : UIViewController<ColorPickerViewControllerDelegate>{
	
	
	IBOutlet UIView *whiteBgView;
	IBOutlet DragLabel *lblName;
	IBOutlet DragLabel *lblTitle;
	IBOutlet DragLabel *lblCompany;
	IBOutlet DragLabel *lblEmail;
	IBOutlet DragLabel *lblPhone1;
	IBOutlet DragLabel *lblPhone2;
	IBOutlet DragLabel *lblAddressLine1;
	IBOutlet DragLabel *lblAddressLine2;
	IBOutlet DragLabel *lblAddressLine3;	
	IBOutlet UIImageView * logoImageView;
}

@property(nonatomic,retain)UIView *whiteBgView;

-(IBAction)dismissView:(id)sender;
-(IBAction)editInfo:(id)sender;
-(IBAction) selectColor:(id)sender;
-(BOOL)isUserDetailsAvailable;


@end
