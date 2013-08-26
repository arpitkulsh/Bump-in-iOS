//
//  ViewCardViewController.h
//  SwapCardViewController
//
//  Created by mac on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CardsDetails.h"
#import "DragLabel.h"
@interface ViewCardViewController : UIViewController<UIActionSheetDelegate> {
	
	IBOutlet UIView *whiteBgView;
	IBOutlet UIButton *btnEdit;
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
	
	NSMutableDictionary *userDataDict;
	//NSString *strName,*strCompany,*strEmail,*strAddress,*strPhone,*strTitle;
	BOOL isEditable;
	BOOL isViewPositionSet;
	
}
@property(nonatomic,assign) BOOL isEditable;
@property(nonatomic,assign) BOOL isViewPositionSet;
//@property(nonatomic,retain)NSString *strName,*strCompany,*strEmail,*strAddress,*strPhone,*strTitle;
@property(nonatomic,retain)NSMutableDictionary *userDataDict;
@property(nonatomic,retain)UIView *whiteBgView;
-(IBAction)showMenu:(id)sender;
-(BOOL)isUserDetailsAvailable;
-(void)retrieveSavedState;
-(void)setTextFitInLabel:(DragLabel *)loLabel;
-(void)saveDefaultFrames;
@end
