//
//  ViewCardViewController.m
//  SwapCardViewController
//
//  Created by mac on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewCardViewController.h"
#import "HomeViewController.h"
#import "EditCardViewController.h"
#import "EditViewPositionController.h"
#import "SelectInfoController.h"
#import "SetInfoPropertiesController.h"
#import "CustomSaveClass.h"

@implementation ViewCardViewController
@synthesize userDataDict;
@synthesize whiteBgView;
@synthesize isEditable;
@synthesize isViewPositionSet;

-(void)retrieveSavedState{
	
	CustomSaveClass *customSave=[[CustomSaveClass alloc]init];
	[customSave retrieveUserDefaults];
	NSLog(@" before reterive the value name...%@",NSStringFromCGRect(lblName.frame));
	lblName=[customSave getLabelProperties:lblName withTag:(NSInteger)lblName.tag];
	NSLog(@" after reterive the value name...%@",NSStringFromCGRect(lblName.frame));
	lblTitle=[customSave getLabelProperties:lblTitle withTag:(NSInteger)lblTitle.tag];
	lblCompany=[customSave getLabelProperties:lblCompany withTag:(NSInteger)lblCompany.tag];
	lblEmail=[customSave getLabelProperties:lblEmail withTag:(NSInteger)lblEmail.tag];
	lblPhone1=[customSave getLabelProperties:lblPhone1 withTag:(NSInteger)lblPhone1.tag];
	lblPhone2=[customSave getLabelProperties:lblPhone2 withTag:(NSInteger)lblPhone2.tag];
	lblAddressLine1=[customSave getLabelProperties:lblAddressLine1 withTag:(NSInteger)lblAddressLine1.tag];
	lblAddressLine2=[customSave getLabelProperties:lblAddressLine2 withTag:(NSInteger)lblAddressLine2.tag];
	lblAddressLine3=[customSave getLabelProperties:lblAddressLine3 withTag:(NSInteger)lblAddressLine3.tag];
	self.whiteBgView.backgroundColor=[customSave.backgroundDict objectForKey:@"bgColor"];
	[customSave release];
	
}
-(void)setTextFitInLabel:(DragLabel *)loLabel
{
	CGSize expectedSize=[[loLabel text] sizeWithFont:loLabel.font constrainedToSize:CGSizeMake(350,100) lineBreakMode:UILineBreakModeWordWrap];
	CGRect newFrame=loLabel.frame;
	newFrame.size=expectedSize;
	loLabel.frame=newFrame;
	
}

-(void)saveDefaultFrames{
	
	CustomSaveClass *customSave=[[CustomSaveClass alloc]init];
	[customSave retrieveUserDefaults];
	[customSave.nameDict setObject:NSStringFromCGRect(lblName.frame) forKey:@"frame"];
	[customSave.titleDict setObject:NSStringFromCGRect(lblTitle.frame) forKey:@"frame"];
	[customSave.companyDict setObject:NSStringFromCGRect(lblCompany.frame) forKey:@"frame"];
	[customSave.emailDict setObject:NSStringFromCGRect(lblEmail.frame) forKey:@"frame"];
	[customSave.phone1Dict setObject:NSStringFromCGRect(lblPhone1.frame) forKey:@"frame"];
	[customSave.phone2Dict setObject:NSStringFromCGRect(lblPhone2.frame) forKey:@"frame"];
	[customSave.addressLine1Dict setObject:NSStringFromCGRect(lblAddressLine1.frame) forKey:@"frame"];
	[customSave.addressLine2Dict setObject:NSStringFromCGRect(lblAddressLine2.frame) forKey:@"frame"];
	[customSave.addressLine3Dict setObject:NSStringFromCGRect(lblAddressLine3.frame) forKey:@"frame"];
	[customSave.backgroundDict setObject:[whiteBgView backgroundColor] forKey:@"bgColor"];
	[customSave.imageDict setObject:NSStringFromCGRect(logoImageView.frame) forKey:@"frame"];
	[customSave saveToUserDefaults];
	[customSave release];
}




// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		/* CGRect frame = CGRectMake(20, 0, 194, 44);
		 UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
		 label.backgroundColor = [UIColor clearColor];
		 label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
		 label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
		 label.textAlignment = UITextAlignmentCenter;
		 label.textColor = [UIColor whiteColor];
		 label.text =@"View Card";  //NSLocalizedString(@"DigiDraw", @"hello");
		 [self.navigationItem setTitleView:label];
		 [label release];*/
		[self.navigationItem setTitle:@"View Card"];
		
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
	
	
	lblAddressLine1.lineBreakMode=UILineBreakModeWordWrap;
	lblCompany.contentMode=UILineBreakModeWordWrap;
	
	//if([self isUserDetailsAvailable] && isEditable)
	//	{
	
	CustomSaveClass *customSave=[[CustomSaveClass alloc]init];
	if (isEditable) {
		NSLog(@"view is Editable");
		
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isViewPositionSet"]) {
			NSLog(@"view is ViewPositionSet");
			
			/** this code is to retrieve values when once default  is saved or change is being made ****/
			[customSave retrieveUserDefaults];
			
			lblName=[customSave getLabelProperties:lblName withTag:(NSInteger)lblName.tag];
			lblTitle=[customSave getLabelProperties:lblTitle withTag:(NSInteger)lblTitle.tag];
			lblCompany=[customSave getLabelProperties:lblCompany withTag:(NSInteger)lblCompany.tag];
			lblEmail=[customSave getLabelProperties:lblEmail withTag:(NSInteger)lblEmail.tag];
			lblPhone1=[customSave getLabelProperties:lblPhone1 withTag:(NSInteger)lblPhone1.tag];
			lblPhone2=[customSave getLabelProperties:lblPhone2 withTag:(NSInteger)lblPhone2.tag];
			lblAddressLine1=[customSave getLabelProperties:lblAddressLine1 withTag:(NSInteger)lblAddressLine1.tag];
			lblAddressLine2=[customSave getLabelProperties:lblAddressLine2 withTag:(NSInteger)lblAddressLine2.tag];
			lblAddressLine3=[customSave getLabelProperties:lblAddressLine3 withTag:(NSInteger)lblAddressLine3.tag];
			logoImageView=[customSave getImageLogoProperties:logoImageView];
			self.whiteBgView.backgroundColor=[customSave.backgroundDict objectForKey:@"bgColor"];
			
		}else {
			
			NSLog(@"view is NOT ViewPositionSet");
			/** this code is to save the defaults frame position to label after init of Info values****/	
			[customSave retrieveUserDefaults];
			lblName.text=[customSave.nameDict objectForKey:@"value"];
			[self setTextFitInLabel:lblName];
			
			lblCompany.text=[customSave.companyDict objectForKey:@"value"];
			[self setTextFitInLabel:lblCompany];
			
			lblTitle.text=[customSave.titleDict objectForKey:@"value"];
			[self setTextFitInLabel:lblTitle];
			
			lblEmail.text=[customSave.emailDict objectForKey:@"value"];
			[self setTextFitInLabel:lblEmail];
			
			lblPhone1.text=[customSave.phone1Dict objectForKey:@"value"];
			[self setTextFitInLabel:lblPhone1];
			
			lblPhone2.text=[customSave.phone2Dict objectForKey:@"value"];
			[self setTextFitInLabel:lblPhone2];
			
			lblAddressLine1.text=[customSave.addressLine1Dict objectForKey:@"value"];
			[self setTextFitInLabel:lblAddressLine1];
			
			lblAddressLine2.text=[customSave.addressLine2Dict objectForKey:@"value"];
			[self setTextFitInLabel:lblAddressLine2];
			
			lblAddressLine3.text=[customSave.addressLine3Dict objectForKey:@"value"];
			[self setTextFitInLabel:lblAddressLine3];
			
			[logoImageView setImage:[UIImage imageWithData:[customSave.imageDict objectForKey:@"imagelogo"]]];
			
			
			//CGPoint loPt=[whiteBgView center];
			//CGRect newFrameLogo=CGRectMake(loPt.x-40.0f, loPt.y-120.0f, 100.0f, 100.0f);
			//logoImageView.frame=newFrameLogo;
			
			[self saveDefaultFrames];	
			isViewPositionSet=YES;
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isViewPositionSet"];
			
		}
		
		
	}
	else
	{
		[customSave retrievefromDictionary:[self userDataDict]];
		
		lblName=[customSave getLabelProperties:lblName withTag:(NSInteger)lblName.tag];
		NSLog(@" after reterive the value name...%@",NSStringFromCGRect(lblName.frame));
		lblTitle=[customSave getLabelProperties:lblTitle withTag:(NSInteger)lblTitle.tag];
		lblCompany=[customSave getLabelProperties:lblCompany withTag:(NSInteger)lblCompany.tag];
		lblEmail=[customSave getLabelProperties:lblEmail withTag:(NSInteger)lblEmail.tag];
		lblPhone1=[customSave getLabelProperties:lblPhone1 withTag:(NSInteger)lblPhone1.tag];
		lblPhone2=[customSave getLabelProperties:lblPhone2 withTag:(NSInteger)lblPhone2.tag];
		lblAddressLine1=[customSave getLabelProperties:lblAddressLine1 withTag:(NSInteger)lblAddressLine1.tag];
		lblAddressLine2=[customSave getLabelProperties:lblAddressLine2 withTag:(NSInteger)lblAddressLine2.tag];
		lblAddressLine3=[customSave getLabelProperties:lblAddressLine3 withTag:(NSInteger)lblAddressLine3.tag];
		logoImageView=[customSave getImageLogoProperties:logoImageView];
		self.whiteBgView.backgroundColor=[customSave.backgroundDict objectForKey:@"bgColor"];
		
		/*if (![lblPhone1 isHidden]) {
			UITextView *phone1Textview=[[UITextView alloc] initWithFrame:lblPhone1.frame];
			phone1Textview.hidden=lblPhone1.hidden;
			phone1Textview.font=lblPhone1.font;
			phone1Textview.textColor=lblPhone1.textColor;
			phone1Textview.text=lblPhone1.text;
			phone1Textview.dataDetectorTypes=UIDataDetectorTypePhoneNumber;
			phone1Textview.editable=NO;
			lblPhone1.hidden=YES;
			[self.whiteBgView addSubview:phone1Textview];
			[phone1Textview release];
		}
		
		*/		
		 		
		/*lblName.text=[[self.userDataDict objectForKey:@"nameDict"] objectForKey:@"value"];
		lblCompany.text=[[self.userDataDict objectForKey:@"companyDict"]objectForKey:@"value"];
		lblTitle.text=[[self.userDataDict objectForKey:@"titleDict"]objectForKey:@"value"];
		lblEmail.text=[[self.userDataDict objectForKey:@"emailDict"]objectForKey:@"value"];			
		lblPhone1.text=[[self.userDataDict objectForKey:@"phone1Dict"]objectForKey:@"value"];
		lblAddressLine1.text=[[self.userDataDict objectForKey:@"address1Dict"]objectForKey:@"value"]; 
		 */
	
	}
	[customSave release];
	
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.whiteBgView.frame=CGRectMake(-30.0f, 70.0f, 380.0f, 280.0f);
	self.whiteBgView.transform=CGAffineTransformMakeRotation(3.14f/2.0f);
	//btnEdit.transform=CGAffineTransformMakeRotation(3.14f/2.0f);
	self.whiteBgView.layer.shadowOffset=CGSizeMake(0, 3);
	self.whiteBgView.layer.shadowRadius=5.0f;
	self.whiteBgView.layer.shadowOpacity=.85f;
	self.whiteBgView.layer.shadowColor=[UIColor blackColor].CGColor;
	
	NSLog(@"bounds of WhiteBg view is=>%@",NSStringFromCGRect(self.whiteBgView.bounds));
	NSLog(@"Frane of WhiteBg view is=>%@",NSStringFromCGRect(self.whiteBgView.frame));
	
	btnEdit.hidden=YES;
	if (isEditable) {
		btnEdit.hidden=NO;
	}
	
	
}
-(IBAction)showMenu:(id)sender{
	
	UIActionSheet *editMenu=[[UIActionSheet alloc]initWithTitle:@"Select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit Info",@"Edit Properties",@"Info Visibe/Hidden",@"Design Card",nil ];
	[editMenu setActionSheetStyle:UIActionSheetStyleBlackOpaque];
	[editMenu showInView:self.view];
	[editMenu release];
	
	
	
	
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch (buttonIndex) {
		case 0:
			NSLog(@"Edit Info");
			/****** call View to Edit user Info *****/
			
			EditCardViewController *editInfo=[[EditCardViewController alloc]initWithNibName:@"EditCardViewController" bundle:nil];
			editInfo.isRootView=NO;
			[self.navigationController pushViewController:editInfo animated:NO];
			[editInfo release];
			break;
			
		case 1:
			NSLog(@"set Info Properties");
			SetInfoPropertiesController *sPC=[[SetInfoPropertiesController alloc]initWithNibName:@"SetInfoPropertiesController" bundle:nil];
			UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:sPC];
			[self presentModalViewController:nav animated:YES];
			[sPC release];
			[nav release];
			break;	
			
		case 2:
			NSLog(@"Info Visibe/Hidden");
			SelectInfoController *selectInfo=[[SelectInfoController alloc]initWithNibName:@"SelectInfoController" bundle:nil];
			[self presentModalViewController:selectInfo animated:YES];
			[selectInfo release];
			break;
			
			
		case 3:
			NSLog(@"Design Card");
			EditViewPositionController *editCardDesign=[[EditViewPositionController alloc]initWithNibName:@"EditViewPositionController" bundle:nil];
			[self presentModalViewController:editCardDesign animated:YES];
			[editCardDesign release];
			break;
			
			
		default:
			break;
	}
	
}


#pragma mark userInfo
-(BOOL)isUserDetailsAvailable{
	
	return ([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"])?YES:NO;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[whiteBgView release];
	[userDataDict release];
	//[strName release];
//	[strCompany release];
//	[strTitle release];
//	[strPhone release];
//	[strEmail release];
//	[strAddress release];
    [super dealloc];
}


@end
