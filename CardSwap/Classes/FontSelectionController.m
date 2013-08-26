//
//  FontSelectionController.m
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FontSelectionController.h"


@implementation FontSelectionController

@synthesize fontSectionedArray;
@synthesize delegate;
@synthesize previousfont;
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"


-(IBAction)selectbuttonPressed:(id)sender{
	NSLog(@"select button press with text=%@",[selectedFontTextfield text]);
	[delegate fontSelectionController:self didSelectFont:[selectedFontTextfield text]];
}

-(IBAction)defaultbuttonPressed:(id)sender{
	
	selectedFontTextfield.text=@"Georgia";
}

-(IBAction)cancelbuttonPressed:(id)sender{
	[delegate fontSelectionController:self didSelectFont:previousfont];
}

#pragma mark TableViewDatasource
// Number of groups
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return [fontSectionedArray count];
}


#define ALPHA_ARRAY [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]
// Section Titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if ([[fontSectionedArray objectAtIndex:section] count]!=0) {
		return [ALPHA_ARRAY objectAtIndex:section];
	}else {
		return @"";
	}

	
}

// Number of rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	 return [[fontSectionedArray objectAtIndex:section] count];	
}


// Produce cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	NSInteger section= [indexPath section];
	UITableViewCell *cell;
	
	// Create cells with accessory checking
	cell = [tableView dequeueReusableCellWithIdentifier:@"checkCell"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"checkCell"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	cell.textLabel.font=[UIFont fontWithName:[[fontSectionedArray objectAtIndex:section]objectAtIndex:row] size:18.0f];
		cell.textLabel.text = [[fontSectionedArray objectAtIndex:section]objectAtIndex:row];
	return cell;
}


// Adding a section index here
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
	return ALPHA_ARRAY;
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
	return 44.0f;
	
}

// Respond to user selection based on the cell type
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	selectedFontTextfield.text=[[fontSectionedArray objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
}

#pragma mark createSection

-(void)createSectionArray:(NSMutableArray *)fontArray
{
	// Build an array with 26 sub-arrays
	fontSectionedArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < 26; i++){
		NSMutableArray *tempArray=[[NSMutableArray alloc] init];
		[fontSectionedArray addObject:tempArray];
		[tempArray release];
		
	}
	for (NSString *fontName in fontArray)
	{
		if ([fontName length] == 0) continue;
		
		// determine which letter starts the name
		NSRange range = [ALPHA rangeOfString:[[fontName substringToIndex:1] uppercaseString]];
		
		// Add the name to the proper array
		[[fontSectionedArray objectAtIndex:range.location] addObject:fontName];
	}
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
	selectedFontTextfield.userInteractionEnabled=NO;
	selectedFontTextfield.text=previousfont;
	
	[self.navigationItem.leftBarButtonItem setTitle:@"Back"];
	
	NSMutableArray *fontArray=[[NSMutableArray alloc] init];
	
	for (NSString *family in [UIFont familyNames]) {
		NSArray *tempArray=[[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:family]];
		[fontArray addObjectsFromArray:tempArray];
		[tempArray release];
	}
	[fontArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	[self createSectionArray:fontArray];
	[fontArray release];
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
	[fontSectionedArray release];
	[previousfont release];
    [super dealloc];
}


@end
