//
//  FontSelectionController.h
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FontSelectionController;

@protocol FontSelectionControllerDelegate <NSObject>

- (void)fontSelectionController:(FontSelectionController *)fontPicker didSelectFont:(NSString *)fontName;

@end

@interface FontSelectionController : UIViewController {
	IBOutlet UITableView *mTableView;
	NSMutableArray *fontSectionedArray;
	IBOutlet UITextField	*selectedFontTextfield;
	
	NSString * previousfont;
	
	id<FontSelectionControllerDelegate> delegate;
	

}

@property(nonatomic,assign)	id<FontSelectionControllerDelegate> delegate;
@property(nonatomic,retain) NSMutableArray * fontSectionedArray;
@property(nonatomic,retain) NSString * previousfont;

-(IBAction)selectbuttonPressed:(id)sender;
-(IBAction)defaultbuttonPressed:(id)sender;
-(IBAction)cancelbuttonPressed:(id)sender;

-(void)createSectionArray:(NSMutableArray *)fontArray;
@end
