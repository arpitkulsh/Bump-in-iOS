//
//  EditCardViewController.m
//  SwapCardViewController
//
//  Created by mac on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EditCardViewController.h"
#import "CardSwapAppDelegate.h"
#import "CardsDetails.h"
#import "HomeViewController.h"
#import "UIImage+Resize.h"
#import "CustomSaveClass.h"

@implementation EditCardViewController
@synthesize scroller;
@synthesize managedObjectContext;
@synthesize isRootView;

#pragma mark keyboardNotification

-(void)registerForKeyboardNotifications{
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
}
// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification

{
	NSLog(@"Keyboard was shown");
	NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
	
    scroller.contentInset = contentInsets;
    scroller.scrollIndicatorInsets = contentInsets;
	
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
	
    if (!CGRectContainsPoint(aRect, activeTextField.frame.origin) ) {
		
		NSLog(@"CGRectcontains Point");
		
        CGPoint scrollPoint = CGPointMake(0.0, activeTextField.frame.origin.y-kbSize.height-44.0f);
		
        [scroller setContentOffset:scrollPoint animated:YES];
		
    }
	
}



// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
	
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;

    scroller.contentInset = contentInsets;
	
    scroller.scrollIndicatorInsets = contentInsets;
	
}


#pragma mark -
#pragma mark viewDelegate

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		
        // Custom initialization.
		/*	CGRect frame = CGRectMake(20, 0, 194, 44);
		 UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
		 label.backgroundColor = [UIColor clearColor];
		 label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
		 label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
		 label.textAlignment = UITextAlignmentCenter;
		 label.textColor = [UIColor whiteColor];
		 label.text =@"Card Swap";  //NSLocalizedString(@"DigiDraw", @"hello");
		 [self.navigationItem setTitleView:label];
		 [label release];*/
		
		[self.navigationItem setTitle:@"Edit My Info"];
		UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(createNewCard:)];
		[self.navigationItem setRightBarButtonItem:rightButton];
		[rightButton release];
		
		
		CardSwapAppDelegate *delegate=[[UIApplication sharedApplication] delegate];
		self.managedObjectContext=[delegate managedObjectContext];
		
		[self registerForKeyboardNotifications];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[imgViewLogo setContentMode:UIViewContentModeScaleAspectFit];
	[imgViewLogo setClipsToBounds:YES];

	customSave=[[CustomSaveClass alloc]init];
	
	if (!isRootView) {
	
		[customSave retrieveUserDefaults];

		txtName.text=([customSave.nameDict objectForKey:@"value"]!=nil)?[customSave.nameDict objectForKey:@"value"]:@"";
		txtCompany.text=([customSave.companyDict objectForKey:@"value"]!=nil)?[customSave.companyDict objectForKey:@"value"]:@"";
		txtTitle.text=([customSave.titleDict objectForKey:@"value"]!=nil)?[customSave.titleDict objectForKey:@"value"]:@"";
		txtEmail.text=([customSave.emailDict objectForKey:@"value"]!=nil)?[customSave.emailDict objectForKey:@"value"]:@"";
		txtPhone1.text=([customSave.phone1Dict objectForKey:@"value"]!=nil)?[customSave.phone1Dict objectForKey:@"value"]:@"";
		txtPhone2.text=([customSave.phone2Dict objectForKey:@"value"]!=nil)?[customSave.phone2Dict objectForKey:@"value"]:@"";
		txtAddressLine1.text=([customSave.addressLine1Dict objectForKey:@"value"]!=nil)?[customSave.addressLine1Dict objectForKey:@"value"]:@"";
		txtAddressLine2.text=([customSave.addressLine2Dict objectForKey:@"value"]!=nil)?[customSave.addressLine2Dict objectForKey:@"value"]:@"";
		txtAddressLine3.text=([customSave.addressLine3Dict objectForKey:@"value"]!=nil)?[customSave.addressLine3Dict objectForKey:@"value"]:@"";
		if([customSave.imageDict objectForKey:@"imagelogo"]){
			@try {
				[imgViewLogo setImage:(UIImage *)[UIImage imageWithData:[customSave.imageDict objectForKey:@"imagelogo"]]];
			}
			@catch (NSException * e) {
				NSLog(@"unable to read image data");
			}
						
		}
		
	}
		
	
	self.scroller.contentSize=CGSizeMake(320, 750);
	self.scroller.backgroundColor=[UIColor whiteColor];
	
	
}


-(IBAction)addPhoto:(id)sender {
	
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	[controller setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
	
	[controller setDelegate:self];
	
	[self presentModalViewController:controller animated:YES];
	
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	NSLog(@"Imagepicker controller delegate");
	UIImage *inImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	if(inImage){
	UIImage *outImage=[inImage thumbnailImage:100 transparentBorder:1 cornerRadius:0 interpolationQuality:1];
	
	//UIImage *outImage=[self resizedImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"] withRect:CGRectMake(0, 0, 100.0f, 100.0f)];
	[imgViewLogo setImage:outImage];	
	}
	[picker dismissModalViewControllerAnimated:YES];
}


-(BOOL)isUserDetailsAvailable{
	
	return ([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"])?YES:NO;
}

-(void)createNewCard:(id)sender{
	
	if (![txtName.text isEqualToString:@""]&&![txtCompany.text isEqualToString:@""]&&![txtEmail.text isEqualToString:@""]&&![txtPhone1.text isEqualToString:@""]&&![txtTitle.text isEqualToString:@""]&&![txtAddressLine1.text isEqualToString:@""]) {
		
		/**********check whether Info exists or not **********/
		if([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"]) {
			[self modifyInfoDict];
		}else {
			[self saveInfoDictFirstTime];
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"infoExists"];
		}
		
		if (isRootView) {
			
			HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
			homeViewController.isViewPositionSet=NO;
			[self.navigationController pushViewController:homeViewController animated:YES];
			[homeViewController release];		
			
		}else {
			[self.navigationController popViewControllerAnimated:NO];
		}
		
		
		//[self clearText];
	}
	else {
		UIAlertView *myAlert = [[UIAlertView alloc]		initWithTitle:@"Please fill all details!!"   message:@""	delegate:self	cancelButtonTitle:@"Ok"	otherButtonTitles:nil];
		[myAlert show];
		[myAlert release];
	}
	
	
	
	
	
}

-(void)saveInfoDictFirstTime{
	
	
	/***************save the Attributes info *********************/	
	
	NSMutableDictionary *nameDict=[[NSMutableDictionary alloc]init];
	nameDict=[CustomSaveClass createMyDict:nameDict withValue:[txtName text] withFontName:@"Georgia-Bold" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 0.0f, 250.0f,350.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]]; 
	
	NSMutableDictionary *companyDict=[[NSMutableDictionary alloc]init];
	companyDict=[CustomSaveClass createMyDict:companyDict withValue:[txtCompany text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 0.0f, 80.0f, 200.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *titleDict=[[NSMutableDictionary alloc]init];
	titleDict=[CustomSaveClass createMyDict:titleDict withValue:[txtTitle text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 100.0f, 250.0f, 250.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *EmailDict=[[NSMutableDictionary alloc]init];
	EmailDict=[CustomSaveClass createMyDict:EmailDict withValue:[txtEmail text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 800.0f,150.0f, 50.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *phone1Dict=[[NSMutableDictionary alloc]init];
	phone1Dict=[CustomSaveClass createMyDict:phone1Dict withValue:[txtPhone1 text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *phone2Dict=[[NSMutableDictionary alloc]init];
	phone2Dict=[CustomSaveClass createMyDict:phone2Dict withValue:[txtPhone2 text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 120.0f, 50.0f, 50.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *addressLine1Dict=[[NSMutableDictionary alloc]init];
	addressLine1Dict=[CustomSaveClass createMyDict:addressLine1Dict withValue:[txtAddressLine1 text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 220.0f, 50.0f, 50.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *addressLine2Dict=[[NSMutableDictionary alloc]init];
	addressLine2Dict=[CustomSaveClass createMyDict:addressLine2Dict withValue:[txtAddressLine2 text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 320.0f, 50.0f, 50.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *addressLine3Dict=[[NSMutableDictionary alloc]init];
	addressLine3Dict=[CustomSaveClass createMyDict:addressLine3Dict withValue:[txtAddressLine3 text] withFontName:@"Georgia" withFontSize:[NSNumber numberWithFloat:17.0f] withFrame:CGRectMake(0.0f, 380.0f, 50.0f, 50.0f) withFontColor:[UIColor darkGrayColor] andHidden:[NSNumber numberWithBool:NO]];
	
	NSMutableDictionary *imageDict=[[NSMutableDictionary alloc]init];
	imageDict=[CustomSaveClass createImageDict:imageDict withimage:imgViewLogo];
	
	UIColor *bgColor=[[UIColor alloc] initWithRed:1.0f green:1.0f blue:220.0f/256.0f alpha:1.0f];
	NSMutableDictionary *bgDict=[[NSMutableDictionary alloc]init];
	[bgDict setObject:bgColor forKey:@"bgColor"];
	
	NSMutableDictionary *allDataDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:nameDict,@"nameDict",companyDict,@"companyDict",titleDict,@"titleDict",EmailDict,@"emailDict",phone1Dict,@"phone1Dict",phone2Dict,@"phone2Dict",addressLine1Dict,@"address1Dict",addressLine2Dict,@"address2Dict",addressLine3Dict,@"address3Dict",imageDict,@"imagelogo",nil];
	
	
		
	customSave.nameDict=[allDataDict objectForKey:@"nameDict"];
	customSave.companyDict=[allDataDict objectForKey:@"companyDict"];
	customSave.titleDict =[allDataDict objectForKey:@"titleDict"];
	customSave.emailDict =[allDataDict objectForKey:@"emailDict"];
	customSave.phone1Dict =[allDataDict objectForKey:@"phone1Dict"];
	customSave.phone2Dict =[allDataDict objectForKey:@"phone2Dict"];
	customSave.addressLine1Dict=[allDataDict objectForKey:@"address1Dict"];
	customSave.addressLine2Dict =[allDataDict objectForKey:@"address2Dict"];
	customSave.addressLine3Dict =[allDataDict objectForKey:@"address3Dict"];
	customSave.imageDict=[allDataDict objectForKey:@"imagelogo"];
	customSave.backgroundDict=bgDict;
	
	[customSave saveToUserDefaults];
	
	
	[nameDict release];
	
	[companyDict release];
	[titleDict release];
	[EmailDict release];
	[phone1Dict release];
	[phone2Dict release];
	[addressLine1Dict release];
	[addressLine2Dict release];
	[addressLine3Dict release];
	[imageDict release];
	[bgColor release];
	[bgDict release];
	
	
}

-(void)modifyInfoDict{
	
	
	[customSave.nameDict setObject:([txtName text])?[txtName text]:@"" forKey:@"value"];
	[customSave.titleDict setObject:txtTitle.text forKey:@"value"];
	[customSave.companyDict setObject:txtCompany.text forKey:@"value"];
	[customSave.emailDict setObject:txtEmail.text forKey:@"value"];
	[customSave.phone1Dict setObject:txtPhone1.text forKey:@"value"];
	[customSave.phone2Dict setObject:txtPhone2.text forKey:@"value"];
	[customSave.addressLine1Dict setObject:txtAddressLine1.text forKey:@"value"];
	[customSave.addressLine2Dict setObject:txtAddressLine2.text forKey:@"value"];
	[customSave.addressLine3Dict setObject:txtAddressLine3.text forKey:@"value"];
		if([imgViewLogo image]){
		@try {
			[customSave.imageDict setObject:UIImagePNGRepresentation([imgViewLogo image]) forKey:@"imagelogo"];
		}
		@catch (NSException * e) {
			NSLog(@"unable to read image data");
		}
		
	}
	[customSave saveToUserDefaults];
	
	
	
}

-(void)clearText{
	txtName.text=@"";
	txtCompany.text=@"";
	txtTitle.text=@"";
	txtEmail.text=@"";
	txtPhone1.text=@"";
	txtAddressLine1.text=@"";
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	activeTextField=textField;
	
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[textField resignFirstResponder];	
	activeTextField=nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	NSInteger nextTag = textField.tag + 1;
	// Try to find next responder
	UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
	if (nextResponder) {
		// Found next responder, so set it.
		[nextResponder becomeFirstResponder];
	} else {
		// Not found, so remove keyboard.
		[textField resignFirstResponder];
	}
	return NO;
}

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
	[scroller release];
	[managedObjectContext release];
	[customSave release];
    [super dealloc];
}

/**************Balvinder modified it on 19 april ************/

@end
