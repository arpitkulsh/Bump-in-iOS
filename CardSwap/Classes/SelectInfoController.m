//
//  SelectInfoController.m
//  CardSwap
//
//  Created by mac on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectInfoController.h"
#import "CustomSaveClass.h"

@implementation SelectInfoController
@synthesize valueArray,visibilityArray;


#pragma mark TableViewDatasource
// Number of groups
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

// Section Titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Uncheck/Check to Hide/Unhide";
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
		cell.accessoryType = UITableViewCellAccessoryNone;
		BOOL isHidden;
		/**** Initialize checkMark of Row ******/
		switch (row) {
			case 0:
				isHidden=[[[customSave nameDict] objectForKey:@"isHidden"] boolValue];
				NSLog(@"Bool value of name dict %@",([[customSave nameDict] objectForKey:@"isHidden"])?@"YES":@"NO");
				NSLog(@"Bool value of name dict ( Number Form )%@",[[customSave nameDict] objectForKey:@"isHidden"]);
				break;
			case 1:
				isHidden=[[[customSave titleDict] objectForKey:@"isHidden"]boolValue];
				break;
			case 2:
				isHidden=[[[customSave companyDict] objectForKey:@"isHidden"]boolValue];
				break;
			case 3:
				
				isHidden=[[[customSave emailDict] objectForKey:@"isHidden"]boolValue];
				break;
			case 4:
				isHidden=[[[customSave phone1Dict] objectForKey:@"isHidden"]boolValue];
				break;
			case 5:
				isHidden=[[[customSave phone2Dict] objectForKey:@"isHidden"]boolValue];
				break;
			case 6:
				isHidden=[[[customSave addressLine1Dict] objectForKey:@"isHidden"]boolValue];
				break;
			case 7:
				isHidden=[[[customSave addressLine2Dict] objectForKey:@"isHidden"]boolValue];
				break;
			case 8:
				isHidden=[[[customSave addressLine3Dict] objectForKey:@"isHidden"]boolValue];
				break;
			case 9:
				isHidden=[[[customSave imageDict] objectForKey:@"isHidden"]boolValue];
				break;
			default:
				isHidden=NO;
				break;
		}
		
		if (isHidden){
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		else{
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		
		
		
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
	
	/** check if the object is not image **/
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
	BOOL isHidden;
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:newIndexPath];
	
	if (cell.accessoryType == UITableViewCellAccessoryNone){
		isHidden=NO;
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else{
		isHidden=YES;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	switch (newIndexPath.row) {
		case 0:
			[[customSave nameDict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 1:
			[[customSave titleDict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 2:
			[[customSave companyDict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 3:
			[[customSave emailDict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 4:
			[[customSave phone1Dict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 5:
			[[customSave phone2Dict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 6:
			[[customSave addressLine1Dict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 7:
			[[customSave addressLine2Dict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 8:
			[[customSave addressLine3Dict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		case 9:
			[[customSave imageDict] setObject:[NSNumber numberWithBool:isHidden] forKey:@"isHidden"];
			break;
		default:
			break;
	}
	
	[self performSelector:@selector(deselect) withObject:NULL afterDelay:0.5];
}

#pragma mark UIViewDelegate

-(IBAction)dismiss:(id)sender{
	[customSave saveToUserDefaults];
	[self dismissModalViewControllerAnimated:YES];
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

-(BOOL)isUserDetailsAvailable{
	
	return ([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"])?YES:NO;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	int value;
	value=1;
	if (value) {
		NSLog(@"Yes=%@",[NSNumber numberWithBool:YES]);
	}
	else {
		NSLog(@"NO=%@",[NSNumber numberWithBool:NO]);
	}
	
	
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
		[valueArray addObject:[UIImage imageWithData:[customSave.imageDict objectForKey:@"imagelogo"]]];
		
	}	
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
	[customSave release];
	if (valueArray!=nil)[valueArray release];
	if (visibilityArray!=nil)[visibilityArray release];
}


@end
