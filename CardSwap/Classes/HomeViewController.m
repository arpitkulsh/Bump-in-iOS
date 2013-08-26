//
//  HomeViewController.m
//  SwapCardViewController
//
//  Created by mac on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

#import "EditCardViewController.h"
#import "ViewCardViewController.h"
#import "CardSwapAppDelegate.h"
#import "CustomCellView.h"
#import "CustomSaveClass.h"
#import "BumpAPI.h"
#import "BumpAPICustomUI.h"
#define kTagSwapbtn 1
#define kTagMyInfobtn 2

@implementation HomeViewController
@synthesize cardDict,cardsTableView,tableArray,whiteBgView;
@synthesize managedObjectContext;
@synthesize lblName,lblCompany;
@synthesize exchangeCardDict;
@synthesize isViewPositionSet;

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
		[self.navigationItem setTitleView:label];
		[self.navigationItem setHidesBackButton:YES animated:NO];
		[label release];*/
		[self.navigationItem setTitle:@"Card Swap"];
		self.navigationItem.rightBarButtonItem=nil;//self.editButtonItem ;
		
		CardSwapAppDelegate *delegate=[[UIApplication sharedApplication] delegate];
		self.managedObjectContext=[delegate managedObjectContext];
		
    }
    return self;
}

-(void)updateViewData{
	CustomSaveClass *customSave=[[CustomSaveClass alloc]init];
	[customSave retrieveUserDefaults];
		NSString *tempName=[customSave.nameDict objectForKey:@"value"];
		//NSString *tempCompany=[[self.cardDict objectForKey:@"allDataDictionary"] objectForKey:@"company"];
		NSString *tempCompany=[customSave.companyDict objectForKey:@"value"];
		self.lblName.text=tempName;
		self.lblCompany.text=tempCompany;
		CGSize expectedSize=[[lblCompany text] sizeWithFont:lblCompany.font constrainedToSize:CGSizeMake(138, 200) lineBreakMode:UILineBreakModeWordWrap];
		CGRect newFrame=lblCompany.frame;
		newFrame.size.height=expectedSize.height;
		lblCompany.frame=newFrame;
		
	[customSave release];
	
	[self fetchNameCompany];
	if(tableArray!=nil){
		[cardsTableView reloadData];
	}
}

-(void)viewDidAppear:(BOOL)animated{
	[self updateViewData];
}
/**Balvinder**/
//-(void) viewWillAppear:(BOOL)animated{
//	
//	[self updateViewData];
//	
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[self.navigationItem setHidesBackButton:YES];
	
	self.whiteBgView.layer.cornerRadius=15.0f;
	self.whiteBgView.layer.shadowOffset=CGSizeMake(0, 3);
	self.whiteBgView.layer.shadowRadius=5.0f;
	self.whiteBgView.layer.shadowOpacity=.85f;
	self.whiteBgView.layer.shadowColor=[UIColor blackColor].CGColor;
	BumpAPI *api = [BumpAPI sharedInstance];
	[api configAPIKey:@"59d5db94740a4e8e8e9ba98ef0e64c84"];
	[api configUIDelegate:self];
	[api configDelegate:self];
	[api requestSession];
	tableArray=[[NSMutableArray alloc] init];
	//self.cardDict=[NSMutableDictionary dictionary];
	
}

-(IBAction) buttonPress:(id)sender{
	
	//NSMutableDictionary *mutablecopy=(NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)sAppDelegate.myCardDict,kCFPropertyListMutableContainers);
	// NSLog(@"copy of created ...%@",mutaablecopy);
    UIButton *buttonClicked=(UIButton *)sender;
	if(buttonClicked.tag==kTagSwapbtn)
	{
		[[BumpAPI sharedInstance] simulateBump];
	}
	if(buttonClicked.tag==kTagMyInfobtn){
			
			ViewCardViewController *cardViewController=[[ViewCardViewController alloc]initWithNibName:@"ViewCardViewController" bundle:nil];
			//cardViewController.userDataDict=[self cardDict];
			cardViewController.isEditable=YES;
			cardViewController.isViewPositionSet=self.isViewPositionSet;
			[self.navigationController pushViewController:cardViewController animated:NO];
			[cardViewController release];
		self.isViewPositionSet=YES;
		}
}


#pragma mark **************CoreData Methods
- (void)fetchRecords:(NSString* )tmpName withCompany:(NSString* )tmpCompany{
	
	// Define our table/entity to use
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"CardsDetails" inManagedObjectContext:managedObjectContext];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	NSDictionary *entityPropeties=[entity propertiesByName];
	NSPropertyDescription *dictPropery=[entityPropeties objectForKey:@"allDataDict"];
	
	[request setPropertiesToFetch:[NSArray arrayWithObject:dictPropery]];
	
	// Define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	[request setReturnsObjectsAsFaults:NO];
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"(name like %@) AND (company like %@)",tmpName,tmpCompany];
	[request setPredicate:predicate];
	// Fetch the records and handle an error
	NSError *error;
	NSMutableArray *managedobjectData=[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (managedobjectData!=nil) {
		
		//[self.tableArray addObjectsFromArray:managedobjectData];
		
		ViewCardViewController *viewCard=[[ViewCardViewController alloc]initWithNibName:@"ViewCardViewController" bundle:nil];
		viewCard.isEditable=NO;
		viewCard.isViewPositionSet=YES;
		//NSLog(@"after unarchieve type of data is=%@",[NSKeyedUnarchiver unarchiveObjectWithData:[[managedobjectData objectAtIndex:0] allDataDict]]);
		NSLog(@"managed Object is...%@",[[managedobjectData objectAtIndex:0] allDataDict]);
		viewCard.userDataDict=[[managedobjectData objectAtIndex:0] allDataDict];//[NSKeyedUnarchiver unarchiveObjectWithData:[[managedobjectData objectAtIndex:0] allDataDict]];
		NSLog(@"Dictionary After retrieving from core data saving %@", [viewCard userDataDict]);
		[self.navigationController pushViewController:viewCard animated:NO];
		[viewCard release];
		NSLog(@"ManagedObject is not nil");
	}
		
	[request release];
	[managedobjectData release];
	
}

- (void)fetchNameCompany{
		 
		 // Define our table/entity to use
		 NSEntityDescription *entity = [NSEntityDescription entityForName:@"CardsDetails" inManagedObjectContext:managedObjectContext];
		 
		 // Setup the fetch request
		 NSFetchRequest *request = [[NSFetchRequest alloc] init];
		 [request setEntity:entity];
		 NSDictionary *entityPropeties=[entity propertiesByName];
		 NSPropertyDescription *namePropery=[entityPropeties objectForKey:@"name"];
		 NSPropertyDescription *companyProperty=[entityPropeties objectForKey:@"company"];
		 [request setPropertiesToFetch:[NSArray arrayWithObjects:namePropery,companyProperty,nil]];
		  
		  // Define how we will sort the records
		  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
		  NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
		  
		  [request setSortDescriptors:sortDescriptors];
		  [sortDescriptor release];
		  
		  // Fetch the records and handle an error
		  NSError *error;
		  NSMutableArray *managedobjectData=[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
		  if (managedobjectData!=nil) {
			  [self.tableArray removeAllObjects];
			  [self.tableArray addObjectsFromArray:managedobjectData];
			  NSLog(@"ManagedObject is not nil in name and comany");
		  }
	
		  if (!tableArray) {
			  
			  // Handle the error.
			  // This is a serious error and should advise the user to restart the application
		  }
		  
		  // Save our fetched data to an array
		  //[self setEventArray: mutableFetchResults];
		  /*	CardsDetails *nameStr=[tableArray objectAtIndex:0];
		   NSLog(@"fetched name is....%@",nameStr.phone);
		   */
	
		  [request release];
		  [managedobjectData release];
		  
}
		  
	 
#pragma mark -
#pragma mark userInfo
-(BOOL)isUserDetailsAvailable{
	
	return ([[NSUserDefaults standardUserDefaults] boolForKey:@"infoExists"])?YES:NO;
}

#pragma mark Create Card DictionaryuserDefaults
-(void) createCardDict{
	CustomSaveClass *customSave=[[CustomSaveClass alloc]init];
	[customSave retrieveUserDefaults];
	
	self.cardDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[customSave nameDict],@"nameDict",[customSave companyDict],@"companyDict",[customSave titleDict],@"titleDict",[customSave emailDict],@"emailDict",[customSave phone1Dict],@"phone1Dict",[customSave phone2Dict],@"phone2Dict",[customSave addressLine1Dict],@"address1Dict",[customSave addressLine2Dict],@"address2Dict",[customSave addressLine3Dict],@"address3Dict",[customSave imageDict],@"imageDict",[customSave backgroundDict],@"backgroundDict",nil];
	[customSave release];
	//CardsDetails *cards = (CardsDetails *)[NSEntityDescription insertNewObjectForEntityForName:@"CardsDetails" inManagedObjectContext:managedObjectContext];
//	[cards setName:[[self.cardDict objectForKey:@"nameDict"] objectForKey:@"value"]];
//	[cards setCompany:[[self.cardDict  objectForKey:@"companyDict"] objectForKey:@"value"]];
//	
//	//NSMutableDictionary *tempDict1=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"Balvinder",@"name",@"Iphone Developer",@"Title",nil];
//	cards.allDataDict=[NSKeyedArchiver archivedDataWithRootObject:[self cardDict]];
//		
//	NSLog(@"New data is with name=%@",[self.cardDict objectForKey:@"nameDict"]);
//	
//	NSError *error;
//	if (![managedObjectContext save:&error]) {
//		NSLog(@"eroor %@",error);
//		//		// This is a serious error saying the record could not be saved.
//		//		// Advise the user to restart the application
//	}
//	
}

#pragma mark **************UITableview Delegate	

-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
	[super setEditing:editing animated:animated];
	[self.cardsTableView setEditing:editing animated:animated];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

//define the total nummber of row in table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//return 10;
	if (tableArray==nil) {
		return 0;
	}else {
		return [tableArray count];
	}
	
	
	
}

//define height for each cell according the text it have to contain
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
		return 45.0f;
	
}
//define properties of each cell of tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Customcell";
	CustomCellView *cell = (CustomCellView *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell=[[[CustomCellView alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:CellIdentifier] autorelease];
		
		
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	/*******Modify @sundeep**********/

	
	cell.lblName.text=((CardsDetails *)[tableArray objectAtIndex:indexPath.row]).name; 
	cell.lblCompany.text=((CardsDetails* )[tableArray objectAtIndex:indexPath.row]).company; 
	
	
	return cell;
	
}
//push firstscreen on the top of view stack of navigation controller
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	CustomCellView *tmpCell = (CustomCellView *)[tableView cellForRowAtIndexPath:indexPath];
	[self fetchRecords:tmpCell.lblName.text withCompany:tmpCell.lblCompany.text];
	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
/**
 * Result of requestSession on BumpAPI (user wants to connect to another device via Bump). UI should
 * now first appear saying something like "Warming up".
 */
-(void)bumpRequestSessionCalled {
	[_label setText:@"Request Session Called... Warming up"];
}

/**
 * We were unable to establish a connection to the Bump network. Either show an error message or
 * hide the popup. The BumpAPIDelegate is about to be called with bumpSessionFailedToStart.
 */
-(void)bumpFailedToConnectToBumpNetwork {
	[_label setText:@"Failed to connect... retrying"];
	[[BumpAPI sharedInstance] requestSession];
}

/**
 * We were able to establish a connection to the Bump network and you are now ready to bump. 
 * The UI should say something like "Ready to Bump".
 */
-(void)bumpConnectedToBumpNetwork {
	[_label setText:@"Ready to Bump"];
}

/**
 * Result of endSession call on BumpAPI. Will soon be followed by the call to bumpSessionEnded: on
 * API delegate. Highly unlikely to happen while the custom UI is up, but provided as a convenience
 * just in case.
 */
-(void)bumpEndSessionCalled {
	[_label	 setText:@"End Session was called"];
	NSLog(@"UI Callback, end session called");
}

/**
 * Once the intial connection to the bump network has been made, there is a chance the connection
 * to the Bump Network is severed. In this case the bump network might come back, so it's
 * best to put the user back in the warming up state. If this happens too often then you can 
 * provide extra messaging and/or explicitly call endSession on the BumpAPI.
 */
-(void)bumpNetworkLost {
	[_label setText:@"Warming up... network was lost"];
}

/**
 * Physical bump occurced. Update UI to tell user that a bump has occured and the Bump System is
 * trying to figure out who it matched with.
 */
-(void)bumpOccurred {
	[_label setText:@"Bumped! Trying to connecect..."];
}

/**
 * Let's you know that a match could not be made via a bump. It's best to prompt users to try again.
 * @param		reason			Why the match failed
 */
-(void)bumpMatchFailedReason:(BumpMatchFailedReason)reason {
	[_label setText:@"Match failed, try again"];
}

/**
 * The user should be presented with some data about who they matched, and whether they want to
 * accept this connection. (Pressing Yes/No should call confirmMatch:(BOOL) on the BumpAPI).
 * param		bumper			Information about the device the bump system mached with
 */
-(void)bumpMatched:(Bumper*)bumper {
	[_label setText:@"Matched! about to start..."];
	
	NSString * errorString = [NSString stringWithFormat:@"Do you want to Exchange the Card with \"%@\"",[bumper userName]];
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO",nil];
	//Modify by Sundeep 15 dec
	[errorAlert setTag:99];//tag used to identify the alert/
	[errorAlert dismissWithClickedButtonIndex:1 animated:YES];
	[errorAlert show];
	[errorAlert release];
	
}

/**
 * Called after both parties have pressed yes, and bumpSessionStartedWith:(Bumper) is about to be 
 * called on the API Delegate. You should now close the matching UI.
 */
-(void)bumpSessionStarted {
	[_label setText:@"Session started!!!"];
}


#pragma mark *********************** API Delegate

/**
 Successfully started a Bump session with another device.
 @param		otherBumper		Let's you know how the other device identifies itself
 Can also be accessed later via the otherBumper method on the API
 */
- (void) bumpSessionStartedWith:(Bumper *)otherBumper {
	/**Modifying Balvinder***/
	NSLog(@"before creating dict");
	[self createCardDict];
	NSLog(@"the created dictionary..%@",self.cardDict);
	/**Endballvinder**/
	NSLog(@"after creating dict");
	NSData *moveChunk=[NSKeyedArchiver archivedDataWithRootObject:self.cardDict];
	[[BumpAPI sharedInstance] sendData:moveChunk];
	[_label setText:@"start sending!!!"];
	NSLog(@"start sending");
	//Start sending data
	//call end session when you're done sending stuff you want
}

/**
 There was an error while trying to start the session these reasons are helpful and let you know
 what's going on
 @param		reason			Why the session failed to start
 */
- (void) bumpSessionFailedToStart:(BumpSessionStartFailedReason)reason {
	NSLog(@"fail to send");
}

/**
 The bump session was ended, reason tells you wheter it was expected or not
 @param		reason			Why the session ended. Could be either expected or unexpected.
 */
- (void) bumpSessionEnded:(BumpSessionEndReason)reason {
	[_label setText:@"Bump session ended"];
	NSLog(@"Session has ended, requesting a new one");
	[[BumpAPI sharedInstance] requestSession];//auto request a new session since we always want
	//to be doing something
}

/**
 The symmetrical call to sendData on the API. When the other device conneced via Bump calls sendData
 this device get's this call back
 @param		reason			Data sent by the other device.
 */
- (void) bumpDataReceived:(NSData *)chunk {
	[_label setText:@"receving data!!!"];
	NSLog(@"receving data");
	self.exchangeCardDict=[NSKeyedUnarchiver unarchiveObjectWithData:chunk];
	//[self.tableArray addObject:self.cardDict];
	//	[self.cardsTableView reloadData];
	CardsDetails *cards = (CardsDetails *)[NSEntityDescription insertNewObjectForEntityForName:@"CardsDetails" inManagedObjectContext:managedObjectContext];
	[cards setName:[[self.exchangeCardDict objectForKey:@"nameDict"] objectForKey:@"value"]];
	[cards setCompany:[[self.exchangeCardDict  objectForKey:@"companyDict"] objectForKey:@"value"]];

	[cards setAllDataDict:[self exchangeCardDict]];
	/*[cards setCompany:[self.exhangeCardDict objectForKey:@"company"]];
	[cards setTitle:[self.exhangeCardDict objectForKey:@"title"]];
	[cards setEmail:[self.exhangeCardDict objectForKey:@"email"]];
	[cards setPhone:[NSNumber numberWithInteger:[[self.exhangeCardDict objectForKey:@"phone"] intValue]]];
	[cards setAddress:[self.exhangeCardDict objectForKey:@"address"]];
	 */
	
	NSLog(@"New data is with name=%@",[self.exchangeCardDict objectForKey:@"name"]);
	
	NSError *error;
	if (![managedObjectContext save:&error]) {
		NSLog(@"error %@",error);
		//		// This is a serious error saying the record could not be saved.
		//		// Advise the user to restart the application
	}
	[self fetchNameCompany];
	if(tableArray!=nil){
		[cardsTableView reloadData];
	}
	[[BumpAPI sharedInstance] endSession];

	
	
	
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if([alertView tag]==99){
		switch (buttonIndex) {
			case 0: 
				[[BumpAPI sharedInstance] confirmMatch:YES];
				break;
				
			case 1://buttton with title "NO"
				[[BumpAPI sharedInstance] confirmMatch:NO];
				[_label setText:@"Ready To Bump"];
				break;
			default:
				break;
		}
		
	}
}



- (void)dealloc {
    [super dealloc];
	[exchangeCardDict release];
	[whitebgView release];
	[lblName release];
	[lblCompany release];
	[managedObjectContext release];
	[tableArray release];
	[cardDict release];
	[cardsTableView release];
}


@end
