//
//  SetInfoPropertiesController.m
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SetInfoPropertiesController.h"
#import "PropertiesViewController.h"
#import "FontSelectionController.h"
#import "CustomSaveClass.h"


@implementation SetInfoPropertiesController

@synthesize valueArray;

-(IBAction)dismissView:(id)sender{
	[customSave saveToUserDefaults];
	[self dismissModalViewControllerAnimated:YES];
	
}
#pragma mark TableViewDatasource
// Number of groups
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

// Section Titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Select Info to modify Properties";
}

// Number of rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(valueArray)return [valueArray count];
	else return 0;
	
}


// Produce cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	UITableViewCell *cell;
	
	// Create cells with accessory checking
	cell = [tableView dequeueReusableCellWithIdentifier:@"checkCell"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"checkCell"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if ([[[[valueArray objectAtIndex:row] class] description] isEqual:@"UIImage"]) {
		cell.textLabel.text=@"Image/Logo";
		[cell.imageView setImage:[valueArray objectAtIndex:row]];
	}else {
		cell.textLabel.text = [NSString stringWithFormat:@"%@",[valueArray objectAtIndex:row]];
	}
	
	
	return cell;
}

// utility functions
- (void) deselect
{	
	[mTableView deselectRowAtIndexPath:[mTableView indexPathForSelectedRow] animated:YES];
}


#pragma mark TableViewDelegate
// Heights per row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	
	/** check if the object is not an image**/
	if (![[[[valueArray objectAtIndex:row] class] description] isEqual:@"UIImage"]) {
		
		NSString *tempString=[NSString stringWithFormat:@"%@",[valueArray objectAtIndex:row]];
		/*** if string is empty no need to display cell ***/
		if ([tempString length]<=0) {
			return 0.0f;
		}else {
			return 44.0f;
		}
	}else {
		return 44.0f;

	}

	
	
}

// Respond to user selection based on the cell type
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
	PropertiesViewController *propView=[[PropertiesViewController alloc] initWithNibName:@"PropertiesViewController" bundle:nil];
	switch (newIndexPath.row) {
		case 0:
			propView.dataDictionary=[customSave nameDict];
				break;
		case 1:
			propView.dataDictionary=[customSave titleDict];
			break;
		case 2:
			propView.dataDictionary=[customSave companyDict];
			break;
		case 3:
			propView.dataDictionary=[customSave emailDict];
			break;
		case 4:
			propView.dataDictionary=[customSave phone1Dict];
			break;
		case 5:
			propView.dataDictionary=[customSave phone2Dict];
			break;
		case 6:
			propView.dataDictionary=[customSave addressLine1Dict];
			break;
		case 7:
			propView.dataDictionary=[customSave addressLine2Dict];
			break;
		case 8:
			propView.dataDictionary=[customSave addressLine3Dict];
			break;
		default:
			break;
	}
	
	
	
	[self.navigationController pushViewController:propView animated:YES];
	[propView release];
	
	
	
	
	/*
	FontSelectionController *propView=[[FontSelectionController alloc] initWithNibName:@"FontSelectionController" bundle:nil];
	[self.navigationController pushViewController:propView animated:YES];
	[propView release];
*/
	 }

-(BOOL)isUserDetailsAvailable{
	
	return ([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"])?YES:NO;
}


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
	
	UIBarButtonItem *button=[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView:)];
	self.navigationItem.leftBarButtonItem=button;
	self.navigationItem.title=@"Set Properties";
	[button release];
	
	customSave=[[CustomSaveClass alloc]init];
	
	valueArray=[[NSMutableArray alloc]init];
	
	
	if([self isUserDetailsAvailable]){
		
		[customSave retrieveUserDefaults];
		
		[valueArray addObject:[customSave.nameDict objectForKey:@"value"]];
		[valueArray addObject:[customSave.titleDict objectForKey:@"value"]];
		[valueArray addObject:[customSave.companyDict objectForKey:@"value"]];
		[valueArray addObject:[customSave.emailDict objectForKey:@"value"]];
		[valueArray addObject:[customSave.phone1Dict objectForKey:@"value"]];
		[valueArray addObject:[customSave.phone2Dict objectForKey:@"value"]];
		[valueArray addObject:[customSave.addressLine1Dict objectForKey:@"value"]];
		[valueArray addObject:[customSave.addressLine2Dict objectForKey:@"value"]];
		[valueArray addObject:[customSave.addressLine3Dict objectForKey:@"value"]];
		
		
		
	}
	
	/* mTableView.backgroundView.layer.borderWidth=5.0f;
	 mTableView.backgroundView.layer.borderColor=[UIColor cyanColor].CGColor;
	 mTableView.backgroundView.layer.cornerRadius=5.0f;
	 */
	
	
	
	
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
	if (valueArray!=nil)[valueArray release];
	[customSave release];
}


@end
