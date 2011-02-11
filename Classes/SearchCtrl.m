//
//  RadrAppViewController.m
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchCtrl.h"
#import "RequestHeader.h"
#import "RadrReqest.h"
#import "SearchListCtrl.h"
#import "Config.h"

@interface SearchCtrl(Private)

-(void)sendAction;

@end

@implementation SearchCtrl
@synthesize applicationTitle;
@synthesize navigationImg, searchingImg;
@synthesize searchTxt;
@synthesize forSaleBtn;
@synthesize forRentBtn;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	reqheader = [[RequestHeader alloc] init];
	[reqheader setHeader:@"search_listings" forKey:(NSString*)header_action];
	searchTxt.returnKeyType = UIReturnKeyDone;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[applicationTitle release], applicationTitle = nil;
	[navigationImg release], navigationImg = nil;
    [searchingImg release], searchingImg = nil;
    [searchTxt release], searchTxt = nil;
	[forSaleBtn release], forSaleBtn = nil;
    [forRentBtn release], forRentBtn = nil;
	[reqheader release], reqheader = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark text delegator
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {        // return NO to disallow editing.
	[UIView beginAnimations:@"moveupAnimation" context:nil];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationTransitionCurlUp];
	CGRect moveUpFrame = [self.view frame];
	moveUpFrame.origin.y -= 140.0f;
	[self.view setFrame:moveUpFrame];
	[UIView commitAnimations];
	
	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {         // became first responder
	
	
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
	[UIView beginAnimations:@"movedownAnimation" context:nil];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationTransitionCurlDown];
	CGRect moveDownFrame = [self.view frame];
	moveDownFrame.origin.y  += 140.0f;
	[self.view setFrame:moveDownFrame];
	[UIView commitAnimations];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called 
	[textField resignFirstResponder];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {   // return NO to not change text
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {               // called when clear button pressed. return NO to ignore (no notifications)
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{              // called when 'return' key pressed. return NO to ignore.
	[textField retain];
	[textField resignFirstResponder];
	[self sendAction];
	return YES;
}

#pragma mark -
#pragma mark button delegator
-(IBAction)forRentBtnPressed: (id)aSender {
	[searchTxt resignFirstResponder];
	[forRentBtn setHighlighted:YES];
	[forSaleBtn setHighlighted:NO];
	[self sendAction];
}
-(IBAction)forSaleBtnPressed: (id)aSender {
	[searchTxt resignFirstResponder];
	[forSaleBtn setHighlighted:YES];
	[forRentBtn setHighlighted:NO];
	[self sendAction];
}

#pragma mark -
#pragma mark Private
-(void)sendAction {
	if ([[searchTxt text] isEqualToString:@""] == NO) {
		if ([forRentBtn isHighlighted]) {
			[reqheader addUserHeader:@"buy" key:@"listing_type"];
		}else {
			[reqheader addUserHeader:@"rent" key:@"listing_type"];
		}
		//[reqheader addUserHeader:@"es" key:@"country"];
		[reqheader addUserHeader: [searchTxt text] key:@"place_name"];
	    RadrReqest* request = [[RadrReqest alloc] initWithHeader:reqheader andDelegator: self];
		//[request sendRequest];
		[request release];

	}
}

#pragma mark -
#pragma mark RadrRequestProtocol

-(void)modelFinished:(RadrModel*)aModel {
    SearchListCtrl* sCtrl = [[SearchListCtrl alloc] initWithStyle:UITableViewStylePlain andModel:aModel];	
	[(UINavigationController*)self.parentViewController pushViewController: sCtrl animated:YES];
	[sCtrl release], sCtrl = nil;
}

-(void)error: (RadrReqest*)aRequest description:(NSString*)aDescription {
	
}
@end
