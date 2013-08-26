//
//  PropertiesViewController.m
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertiesViewController.h"
#import "FontSelectionController.h"


@implementation PropertiesViewController

@synthesize dataDictionary;

-(IBAction)selectFontName:(id)Sender{
	
	FontSelectionController *fontSelect=[[FontSelectionController alloc] initWithNibName:@"FontSelectionController" bundle:nil];
	fontSelect.previousfont=textFieldFontName.text;
	fontSelect.delegate=self;
	[self presentModalViewController:fontSelect animated:YES];
	[fontSelect release];
	
}

-(IBAction)selectFontSize:(id)Sender{
	
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
	[actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
	[pickerForFontSize selectRow:([textFieldFontSize.text intValue]-8) inComponent:0 animated:NO];
}

-(IBAction)selectFontColor:(id)sender;

{
	ColorPickerViewController *colorPickerViewController = 
	[[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
    colorPickerViewController.delegate = self;
#ifdef IPHONE_COLOR_PICKER_SAVE_DEFAULT
    colorPickerViewController.defaultsKey = @"SwatchColor";
#else
    // We re-use the current value set to the background of this demonstration view
    colorPickerViewController.defaultsColor = viewFontColor.backgroundColor;
#endif
	
    [self presentModalViewController:colorPickerViewController animated:YES];
    [colorPickerViewController release];
}

#pragma mark PickerviewDelegate




-(void)dismissActionSheet:(id)sender{
	[actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}	


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
		    return [sizeArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

	
		return [sizeArray objectAtIndex:row];
}




- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	[textFieldFontSize setText:[sizeArray objectAtIndex:row]];
	//self.pickerForFontSize.hidden=YES;
	
}

#pragma mark colorPickerViewDelegate

- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    NSLog(@"Color: %d",color);
    
#ifdef IPHONE_COLOR_PICKER_SAVE_DEFAULT
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:colorPicker.defaultsKey];
    
    if ([colorPicker.defaultsKey isEqualToString:@"SwatchColor"]) {
        viewFontColor.backgroundColor = color;
    }
#else
    // No storage & check, just assign back the color
    viewFontColor.backgroundColor = color;
#endif
	
	
    [colorPicker dismissModalViewControllerAnimated:YES];
}


#pragma mark FontSelectionControllerDelegate

- (void)fontSelectionController:(FontSelectionController *)fontPicker didSelectFont:(NSString *)fontName{
	[textFieldFontName setText:[NSString stringWithString:fontName]];
	[textFieldFontName setFont:[UIFont fontWithName:fontName size:16.0f]];
	 [fontPicker dismissModalViewControllerAnimated:YES];
}


#pragma mark viewDelegate


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	view1.layer.cornerRadius=10.0f;
	view1.layer.borderColor=[UIColor lightGrayColor].CGColor;
	view1.layer.borderWidth=2.0f;
	
	view2.layer.cornerRadius=10.0f;
	view2.layer.borderColor=[UIColor lightGrayColor].CGColor;
	view2.layer.borderWidth=2.0f;
	
	view3.layer.cornerRadius=10.0f;
	view3.layer.borderColor=[UIColor lightGrayColor].CGColor;
	view3.layer.borderWidth=2.0f;
	
	viewFontColor.layer.cornerRadius=8.0f;
	viewFontColor.layer.borderColor=[UIColor lightGrayColor].CGColor;
	viewFontColor.layer.borderWidth=2.0f;
	
	textFieldFontName.text=[dataDictionary objectForKey:@"fontName"];
	viewFontColor.backgroundColor=[dataDictionary objectForKey:@"fontColor"];
	textFieldFontSize.text=[[dataDictionary objectForKey:@"fontSize"] stringValue];

	sizeArray=[[NSArray alloc] initWithObjects: @"8",@"9",@"10",@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",@"21",@"22",@"23",@"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"41",@"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49",@"50",nil];
	
	//Initiallize pickerview in actionsheet with done button
	actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
											  delegate:nil
									 cancelButtonTitle:nil
								destructiveButtonTitle:nil
									 otherButtonTitles:nil];
	
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	
	CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
	
	pickerForFontSize = [[UIPickerView alloc] initWithFrame:pickerFrame];
	pickerForFontSize.showsSelectionIndicator = YES;
	 ///set the current selected value
	pickerForFontSize.dataSource = self;
	pickerForFontSize.delegate = self;
	[actionSheet addSubview:pickerForFontSize];
	
	
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	closeButton.momentary = YES; 
	closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor blackColor];
	[closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
	[actionSheet addSubview:closeButton];
	[closeButton release];
	//end of Pickerview initiallization	
	
	
	[pickerForFontSize reloadComponent:0];

	[self.navigationItem.leftBarButtonItem setTitle:@"Back"];
	NSLog(@"Name of Font Family in Iphone are");
	for (NSString *family in [UIFont familyNames]) {
		//NSLog(@"%@",family);
		NSLog(@"%@",[UIFont fontNamesForFamilyName:family]);
	}
}


-(void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[dataDictionary setObject:textFieldFontName.text forKey:@"fontName"];
	[dataDictionary setObject:viewFontColor.backgroundColor forKey:@"fontColor"];
	[dataDictionary setObject:[NSNumber numberWithInt:[textFieldFontSize.text intValue]] forKey:@"fontSize"];

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
    [super dealloc];
	[pickerForFontSize release];
	[actionSheet release];
	[sizeArray release];
}


@end
