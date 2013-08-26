//
//  CustomSaveClass.h
//  FrameSave
//
//  Created by mac on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DragLabel.h"

@interface CustomSaveClass : NSObject {
	//NSMutableDictionary *allDataDict;
	NSMutableDictionary *nameDict;
	NSMutableDictionary *titleDict;
	NSMutableDictionary *companyDict;
	NSMutableDictionary *emailDict;
	NSMutableDictionary *phone1Dict;
	NSMutableDictionary *phone2Dict;
	NSMutableDictionary *addressLine1Dict;
	NSMutableDictionary *addressLine2Dict;
	NSMutableDictionary *addressLine3Dict;
	NSMutableDictionary *imageDict;
	NSMutableDictionary *backgroundDict;
	
}
@property(nonatomic, retain) NSMutableDictionary *titleDict, *nameDict,*companyDict,*emailDict,*phone1Dict,*phone2Dict,*addressLine1Dict,*addressLine2Dict,*addressLine3Dict,*imageDict,*backgroundDict;

+(NSMutableDictionary *)createMyDict:(NSMutableDictionary *)lodict withValue:(NSString *)value withFontName:(NSString* )fontName withFontSize:(NSNumber *)fontSize withFrame:(CGRect)frame withFontColor:(UIColor* )fontColor andHidden:(NSNumber* )isHidden;
+(NSMutableDictionary *)createImageDict:(NSMutableDictionary *)loimgDict withimage: (UIImageView *)imageView;
-(void)setTextFitInLabel:(DragLabel *)loLabel;
-(UIImageView *)getImageLogoProperties:(UIImageView *)logoImageView;

-(void)saveToUserDefaults;
-(void)retrieveUserDefaults;
-(void)retrievefromDictionary:(NSMutableDictionary *)allDataDict;
-(DragLabel *)getLabelProperties:(DragLabel *)tempLabel withTag:(NSInteger)labelTag;
@end
