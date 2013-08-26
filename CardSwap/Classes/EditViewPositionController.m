//
//  EditViewPositionController.m
//  CardSwap
//
//  Created by mac on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EditViewPositionController.h"
#import "HomeViewController.h"
#import "EditCardViewController.h"
#import "DragLabel.h"
#import "CustomSaveClass.h"
@implementation EditViewPositionController

@synthesize whiteBgView;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.


#pragma mark colorPickerMethod

-(IBAction) selectColor:(id)sender {
    ColorPickerViewController *colorPickerViewController = 
	[[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
    colorPickerViewController.delegate = self;
#ifdef IPHONE_COLOR_PICKER_SAVE_DEFAULT
    colorPickerViewController.defaultsKey = @"SwatchColor";
#else
    // We re-use the current value set to the background of this demonstration view
    colorPickerViewController.defaultsColor = whiteBgView.backgroundColor;
#endif
    [self presentModalViewController:colorPickerViewController animated:YES];
    [colorPickerViewController release];
}



- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    NSLog(@"Color: %d",color);
    
#ifdef IPHONE_COLOR_PICKER_SAVE_DEFAULT
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:colorPicker.defaultsKey];
    
    if ([colorPicker.defaultsKey isEqualToString:@"SwatchColor"]) {
        whiteBgView.backgroundColor = color;
    }
#else
    // No storage & check, just assign back the color
    whiteBgView.backgroundColor = color;
#endif
	
	
    [colorPicker dismissModalViewControllerAnimated:YES];
}

-(IBAction)dismissView:(id)sender{
	
	[self dismissModalViewControllerAnimated:YES];
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		// Custom initialization.
		CGRect frame = CGRectMake(20, 0, 194, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
		label.text =@"View Card";  //NSLocalizedString(@"DigiDraw", @"hello");
		
		[self.navigationItem setTitleView:label];
		[label release];
		
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
	
	
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
	logoImageView=[customSave getImageLogoProperties:logoImageView];
	self.whiteBgView.backgroundColor=[customSave.backgroundDict objectForKey:@"bgColor"];
	[customSave release];
	
	NSLog(@"Design card: bounds of WhiteBg view is=>%@",NSStringFromCGRect(self.whiteBgView.bounds));
	NSLog(@"Design card: Frane of WhiteBg view is=>%@",NSStringFromCGRect(self.whiteBgView.frame));
}

-(BOOL)isUserDetailsAvailable{
	
	return ([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"])?YES:NO;
}


-(IBAction)editInfo:(id)sender{
	EditCardViewController *edit=[[EditCardViewController alloc]initWithNibName:@"EditCardViewController" bundle:nil];
	edit.isRootView=NO;
	[self.navigationController pushViewController:edit animated:NO];
	[edit release];
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
-(void)viewWillDisappear:(BOOL)animated
{
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
	[customSave saveToUserDefaults];
	[customSave release];
}
- (void)viewDidUnload {
    [super viewDidUnload];
	
}


- (void)dealloc {
	[whiteBgView release];
    [super dealloc];
}


@end
