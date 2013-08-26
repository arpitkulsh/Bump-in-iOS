//
//  HomeViewController.h
//  SwapCardViewController
//
//  Created by mac on 3/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CardsDetails.h"
#import "BumpAPI.h"
#import "BumpAPICustomUI.h"


@interface HomeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,BumpAPICustomUI,BumpAPIDelegate,UIAlertViewDelegate>{
	NSManagedObjectContext *managedObjectContext;
	UIView *whitebgView;
	NSMutableDictionary *cardDict;
	NSMutableDictionary *exchangeCardDict;
	UITableView *cardsTableView;
	IBOutlet UILabel *_label;
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *lblCompany;
	NSMutableArray *tableArray;
	BOOL isViewPositionSet;
	
	
}
@property(nonatomic)BOOL isViewPositionSet;
@property(nonatomic,retain)NSMutableArray *tableArray;
@property(nonatomic,retain)IBOutlet UITableView *cardsTableView;
@property(nonatomic,retain)NSMutableDictionary *cardDict;
@property(nonatomic,retain)NSMutableDictionary *exchangeCardDict;
@property(nonatomic, retain)IBOutlet UIView *whiteBgView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain)IBOutlet UILabel *lblCompany;
@property(nonatomic,retain)IBOutlet UILabel *lblName;

-(IBAction)buttonPress:(id)sender;
-(BOOL)isUserDetailsAvailable;
- (void)fetchRecords:(NSString* )tmpName withCompany:(NSString*)tmpCompany;
- (void)fetchNameCompany;
-(void)updateViewData;
-(void) createCardDict;
@end
