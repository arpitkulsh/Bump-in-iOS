//
//  CustomSaveClass.m
//  FrameSave
//
//  Created by mac on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomSaveClass.h"

@implementation CustomSaveClass
@synthesize nameDict,titleDict,companyDict,emailDict,phone1Dict,phone2Dict,addressLine1Dict,addressLine2Dict,addressLine3Dict,imageDict,backgroundDict;
+(NSMutableDictionary *)createMyDict:(NSMutableDictionary *)lodict withValue:(NSString *)value withFontName:(NSString* )fontName withFontSize:(NSNumber *)fontSize withFrame:(CGRect)tmpframe withFontColor:(UIColor *)fontColor andHidden:(NSNumber *)isHidden
{
	[lodict setObject:value forKey:@"value"];
	[lodict setObject:fontName forKey:@"fontName"];
	[lodict setObject:fontColor forKey:@"fontColor"];
	[lodict setObject:fontSize forKey:@"fontSize"];
	[lodict setObject:NSStringFromCGRect(tmpframe) forKey:@"frame"];
	[lodict setObject:isHidden forKey:@"isHidden"];
	NSLog(@"Bool value of name dict ( Number Form )%@",[lodict objectForKey:@"isHidden"]);
	return lodict;
}

+(NSMutableDictionary *)createImageDict:(NSMutableDictionary *)loimgDict withimage:(UIImageView *)imageView
{
	[loimgDict setObject:UIImagePNGRepresentation([imageView image]) forKey:@"imagelogo"]; 
	[loimgDict setObject:NSStringFromCGRect([imageView frame]) forKey:@"frame"];
	[loimgDict setObject:[NSNumber numberWithBool:NO] forKey:@"isHidden"];
	return loimgDict;
	
}

-(void)saveToUserDefaults{

	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSData *namedata = [NSKeyedArchiver archivedDataWithRootObject:nameDict];
	NSData *compdata=[NSKeyedArchiver archivedDataWithRootObject:companyDict];
	NSData *titldata=[NSKeyedArchiver archivedDataWithRootObject:titleDict];
	NSData *emaildata=[NSKeyedArchiver archivedDataWithRootObject:emailDict];
	NSData *phone1data=[NSKeyedArchiver archivedDataWithRootObject:phone1Dict];
	NSData *phone2data=[NSKeyedArchiver archivedDataWithRootObject:phone2Dict];
	NSData *address1data=[NSKeyedArchiver archivedDataWithRootObject:addressLine1Dict];
	NSData *address2data=[NSKeyedArchiver archivedDataWithRootObject:addressLine2Dict];
	NSData *address3data=[NSKeyedArchiver archivedDataWithRootObject:addressLine3Dict];
	NSData *imageData=[NSKeyedArchiver archivedDataWithRootObject:imageDict];
	NSData *bgData=[NSKeyedArchiver archivedDataWithRootObject:backgroundDict];
	
	[standardUserDefaults setObject:namedata forKey:@"name"];
	[standardUserDefaults setObject:compdata forKey:@"company"];
	[standardUserDefaults setObject:titldata forKey:@"title"];
	[standardUserDefaults setObject:emaildata forKey:@"email"];
	[standardUserDefaults setObject:phone1data forKey:@"phone1"];
	[standardUserDefaults setObject:phone2data forKey:@"phone2"];
	[standardUserDefaults setObject:address1data forKey:@"address1"];
	[standardUserDefaults setObject:address2data forKey:@"address2"];
	[standardUserDefaults setObject:address3data forKey:@"address3"];
	[standardUserDefaults setObject:imageData forKey:@"imageDict"];
	[standardUserDefaults setObject:bgData forKey:@"backgroundDict"];
	
	[standardUserDefaults synchronize];
	
	
}

-(void)retrieveUserDefaults
{
	
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	
	if (standardUserDefaults){ 
		
		NSData *namedata=[standardUserDefaults objectForKey:@"name"];
		self.nameDict = [NSKeyedUnarchiver unarchiveObjectWithData:namedata];
		NSData *compdata=[standardUserDefaults objectForKey:@"company"];
		self.companyDict = [NSKeyedUnarchiver unarchiveObjectWithData:compdata];
		NSData *titldata=[standardUserDefaults objectForKey:@"title"];
		self.titleDict = [NSKeyedUnarchiver unarchiveObjectWithData:titldata];
		NSData *emaildata=[standardUserDefaults objectForKey:@"email"];
		self.emailDict = [NSKeyedUnarchiver unarchiveObjectWithData:emaildata];
		NSData *phone1data=[standardUserDefaults objectForKey:@"phone1"];
		self.phone1Dict = [NSKeyedUnarchiver unarchiveObjectWithData:phone1data];
		NSData *phone2data=[standardUserDefaults objectForKey:@"phone2"];
		self.phone2Dict = [NSKeyedUnarchiver unarchiveObjectWithData:phone2data];
		NSData *address1data=[standardUserDefaults objectForKey:@"address1"];
		self.addressLine1Dict = [NSKeyedUnarchiver unarchiveObjectWithData:address1data];
		NSData *address2data=[standardUserDefaults objectForKey:@"address2"];
		self.addressLine2Dict = [NSKeyedUnarchiver unarchiveObjectWithData:address2data];
		NSData *address3data=[standardUserDefaults objectForKey:@"address3"];
		self.addressLine3Dict = [NSKeyedUnarchiver unarchiveObjectWithData:address3data];
		NSData *imagedata=[standardUserDefaults objectForKey:@"imageDict"];
		self.imageDict=[NSKeyedUnarchiver unarchiveObjectWithData:imagedata];
		NSData *bgData=[standardUserDefaults objectForKey:@"backgroundDict"];
		self.backgroundDict=[NSKeyedUnarchiver unarchiveObjectWithData:bgData];
	}
	
}


-(void)retrievefromDictionary:(NSMutableDictionary *)allDataDict
{
		if (allDataDict){ 
	
			self.nameDict=[allDataDict objectForKey:@"nameDict"];
			self.companyDict=[allDataDict objectForKey:@"companyDict"];
			self.titleDict=[allDataDict objectForKey:@"titleDict"];
			self.emailDict=[allDataDict objectForKey:@"emailDict"];
			self.phone1Dict=[allDataDict objectForKey:@"phone1Dict"];
			self.phone2Dict=[allDataDict objectForKey:@"phone2Dict"];
			self.addressLine1Dict=[allDataDict objectForKey:@"address1Dict"];
			self.addressLine2Dict=[allDataDict objectForKey:@"address2Dict"];
			self.addressLine3Dict=[allDataDict objectForKey:@"address3Dict"];
			self.imageDict=[allDataDict objectForKey:@"imageDict"];
			self.backgroundDict=[allDataDict objectForKey:@"backgroundDict"];
	}
	
}




-(DragLabel *)getLabelProperties:(DragLabel *)tempLabel withTag:(NSInteger)labelTag
{  
	
	switch (labelTag ) {
		case 1:
		{
			tempLabel.frame=CGRectFromString([self.nameDict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.nameDict objectForKey:@"fontName"] size:[[self.nameDict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.nameDict objectForKey:@"value"];
			tempLabel.textColor=[self.nameDict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.nameDict objectForKey:@"isHidden"] boolValue];
		}
			break;
		case 2:
			tempLabel.frame=CGRectFromString([self.titleDict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.titleDict objectForKey:@"fontName"] size:[[self.titleDict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.titleDict objectForKey:@"value"];
			tempLabel.textColor=[self.titleDict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.titleDict objectForKey:@"isHidden"] boolValue];
			NSLog(@"Bool value of name dict %@",([[[self titleDict] objectForKey:@"isHidden"] boolValue])?@"YES":@"NO");
				break;
		case 3:
			tempLabel.frame=CGRectFromString([self.companyDict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.companyDict objectForKey:@"fontName"] size:[[self.companyDict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.companyDict objectForKey:@"value"];
			tempLabel.textColor=[self.companyDict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.companyDict objectForKey:@"isHidden"]boolValue];
			NSLog(@"Bool value of name dict %@",([[[self companyDict] objectForKey:@"isHidden"] boolValue])?@"YES":@"NO");
			break;
		case 4:
			tempLabel.frame=CGRectFromString([self.emailDict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.emailDict objectForKey:@"fontName"] size:[[self.emailDict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.emailDict objectForKey:@"value"];
			tempLabel.textColor=[self.emailDict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.emailDict objectForKey:@"isHidden"] boolValue];
			break;
		case 5:
			tempLabel.frame=CGRectFromString([self.phone1Dict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.phone1Dict objectForKey:@"fontName"] size:[[self.phone1Dict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.phone1Dict objectForKey:@"value"];
			tempLabel.textColor=[self.phone1Dict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.phone1Dict objectForKey:@"isHidden"] boolValue];
			break;
		case 6:
			tempLabel.frame=CGRectFromString([self.phone2Dict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.phone2Dict objectForKey:@"fontName"] size:[[self.phone2Dict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.phone2Dict objectForKey:@"value"];
			tempLabel.textColor=[self.phone2Dict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.phone2Dict objectForKey:@"isHidden"] boolValue];
			break;
		case 7:
			tempLabel.frame=CGRectFromString([self.addressLine1Dict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.addressLine1Dict objectForKey:@"fontName"] size:[[self.addressLine1Dict objectForKey:@"fontSize"]floatValue]] ;
			tempLabel.text=[self.addressLine1Dict objectForKey:@"value"];
			tempLabel.textColor=[self.addressLine1Dict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.addressLine1Dict objectForKey:@"isHidden"] boolValue];
			break;
		case 8:
			tempLabel.frame=CGRectFromString([self.addressLine2Dict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.addressLine2Dict objectForKey:@"fontName"] size:[[self.addressLine2Dict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.addressLine2Dict objectForKey:@"value"];
			tempLabel.textColor=[self.addressLine2Dict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.addressLine2Dict objectForKey:@"isHidden"] boolValue];
			
			break;
		case 9:
			tempLabel.frame=CGRectFromString([self.addressLine3Dict objectForKey:@"frame"]);
			tempLabel.font=[UIFont fontWithName:[self.addressLine3Dict objectForKey:@"fontName"] size:[[self.addressLine3Dict objectForKey:@"fontSize"]floatValue]];
			tempLabel.text=[self.addressLine3Dict objectForKey:@"value"];
			tempLabel.textColor=[self.addressLine3Dict objectForKey:@"fontColor"];
			tempLabel.hidden=[[self.addressLine3Dict objectForKey:@"isHidden"] boolValue];
			
			break;

		default:
			break;
	}
	
	[self setTextFitInLabel:tempLabel];
	
	return tempLabel ;
}

-(UIImageView *)getImageLogoProperties:(UIImageView *)logoImageView{
	
	logoImageView.frame=CGRectFromString([self.imageDict objectForKey:@"frame"]);
	[logoImageView setImage:[UIImage imageWithData:[self.imageDict objectForKey:@"imagelogo"]]];
	[logoImageView setHidden:[[self.imageDict objectForKey:@"isHidden"] boolValue]];
	
	return logoImageView;
}

-(void)setTextFitInLabel:(DragLabel *)loLabel
{
	CGSize expectedSize=[[loLabel text] sizeWithFont:loLabel.font constrainedToSize:CGSizeMake(350,100) lineBreakMode:UILineBreakModeWordWrap];
	CGRect newFrame=loLabel.frame;
	newFrame.size=expectedSize;
	loLabel.frame=newFrame;
	
}
-(void) dealloc{
	[super dealloc];
	[nameDict release];
	[titleDict release];
	[companyDict release];
	[emailDict release];
	[phone1Dict release];
	[phone2Dict release];
	[addressLine1Dict release];
	[addressLine2Dict release];
	[addressLine3Dict release];
	[imageDict release];
	[backgroundDict release];
}

@end
