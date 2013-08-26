//
//  EditCardViewController.h
//  SwapCardViewController
//
//  Created by mac on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CardsDetails.h"

@class CustomSaveClass;
@interface EditCardViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
	NSManagedObjectContext *managedObjectContext;
	
	UIScrollView *scroller;
	IBOutlet UITextField *txtName;
	IBOutlet UITextField *txtCompany;
	IBOutlet UITextField *txtTitle;
	IBOutlet UITextField *txtEmail;
	IBOutlet UITextField *txtPhone1;
	IBOutlet UITextField *txtPhone2;
	IBOutlet UITextField *txtAddressLine1;
	IBOutlet UITextField *txtAddressLine2;
	IBOutlet UITextField *txtAddressLine3;
	IBOutlet UIImageView *imgViewLogo;
	UITextField *activeTextField;
	BOOL isRootView;
	
	CustomSaveClass *customSave;
	
} 
@property(assign)BOOL isRootView;
@property(nonatomic,retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

//-(UIImage *)resizedImage:(UIImage *)inImage withRect:(CGRect) thumbRect;
-(IBAction)addPhoto:(id)sender;
-(IBAction)createNewCard:(id)sender;
//- (IBAction)fetchRecords:(id)sender;
-(BOOL)isUserDetailsAvailable;
-(void)registerForKeyboardNotifications;
-(void)clearText;
-(void)saveInfoDictFirstTime;
-(void)modifyInfoDict;
@end
