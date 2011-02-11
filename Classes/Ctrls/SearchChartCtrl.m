//
//  SearchChartCtrl.m
//  RadrApp
//
//  Created by zhangdong on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchChartCtrl.h"
#import "RadrModel.h"
#import "RequestObject.h"
#import "ResponseObject.h"
#import "RequestHeader.h"
#import "Config.h"

const static NSString* CONST_GOOGLE_CHAR_API = @"https://chart.googleapis.com/chart?";





@implementation SearchChartCtrl
@synthesize chartView, chartTableView;
@synthesize model;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

-(id)initWithMode: (RadrModel*)aMode {
	self.model = aMode;
    if (self = [super init]) {
		
	
		
	}
	return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		imageData = [[NSMutableData alloc] init];
     }
    return self;
}



-(NSString*)createGoogleChartURLString {
	NSMutableString* url = [[NSMutableString alloc] initWithString:(NSString*)CONST_GOOGLE_CHAR_API];
	NSArray* header_keys = [[NSArray alloc] initWithObjects:
							 @"chbh", @"chco", @"chd", @"chdl", @"chdlp", @"chdls", @"chds", @"chem", @"chf", @"chf", @"chf", @"chfd", @"chg", 
							 @"chl", @"chld", @"chls", @"chm", @"chma", @"choe", @"chof", @"chp", @"chs", @"chst", @"cht", @"chtm", @"chtt",
							 @"chts", @"chxt", @"chxr", @"chxl", @"chxp", @"chxs", @"chxtc", nil];
	NSMutableArray* header_values = [[NSMutableArray alloc] init];
	for (NSString* key  in header_keys) {
		[header_values addObject:@""];
	}
	NSMutableDictionary* headers = [[NSMutableDictionary alloc] initWithObjects: header_values forKeys:header_keys];
	[headers setObject:@"lc" forKey:@"cht"];
	[headers setObject:@"x,y" forKey:@"chxt"];
	[headers setObject:@"0:|Jan|Feb|March|April|May|1:|Min|Mid|Max" forKey:@"chxl"];
	[headers setObject:@"D,003971,1,0,3|@a,000000,0,.25:.75,7|@tExpected,000000,0,.35:.85,10" forKey:@"chm"];
	CGSize s = chartView.bounds.size;
	int width = (int)s.width;
	int height = (int)s.height;
	NSString* size = [NSString stringWithFormat:@"%dx%d", width, height];
	[headers setObject:size forKey:@"chs"];

	NSArray* keys = [headers allKeys];
	for (NSString* key in keys) {
		NSString* value = [headers objectForKey:key];
		if ([value isEqualToString:@""]) {
			continue;
		}
		NSMutableString* valueMutable = [[NSMutableString alloc] initWithString:value];
		[valueMutable replaceOccurrencesOfString:@"|" withString:@"%7C" options:NSLiteralSearch range:NSMakeRange(0, [valueMutable length])];
		[valueMutable replaceOccurrencesOfString:@":" withString:@"%3A" options:NSLiteralSearch range:NSMakeRange(0, [valueMutable length])];
		[valueMutable replaceOccurrencesOfString:@" " withString:@"%20" options:NSLiteralSearch range:NSMakeRange(0, [valueMutable length])];

		[url appendFormat:@"%@=%@&", key, valueMutable];
		[valueMutable release], valueMutable = nil;
	}
    [url replaceCharactersInRange:NSMakeRange([url length] - 1, 1) withString:@""];
	NSLog(@"url: %@", url);
	[header_keys release], header_keys = nil;
	[header_values release], header_values = nil;
	[headers release], headers = nil;
	return [url autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	CGRect viewRect = self.view.frame;
	CGRect chartRect = viewRect;
	CGRect tableRect = viewRect;
	chartRect.size.height = chartRect.size.height / 2.0f - 10.0f;
	self.view.backgroundColor = [UIColor blueColor];
	tableRect.size.height = chartRect.size.height - 10.0f;
	tableRect.origin.y = chartRect.size.height + 20.0f;
	chartView = [[UIImageView alloc] initWithFrame:chartRect];	
	chartView.backgroundColor = [UIColor redColor];

	chartTableView = [[UIView alloc] initWithFrame:tableRect];
	
	[self.view addSubview: chartView];
	[self.view addSubview:chartTableView];
	
	UINavigationItem* navItem = self.navigationItem;
	if ([model.request.listing_type isEqualToString:@"rent"]) {
		navItem.title = NSLocalizedString(@"Average rental prices", @"SearchChartCtrl--navitation title rent");	
	}else {
		navItem.title = NSLocalizedString(@"Average sale prices", @"SearchChartCtrl--navitation title sale");	
	}
	
	RequestHeader* chartDataHeader = [[RequestHeader alloc] init];
	[chartDataHeader addUserHeader:@"metadata" key:header_action];
	[chartDataHeader addUserHeader:model.request.location key:@"place_name"];
	RadrReqest* chartRequest = [[RadrReqest alloc] initWithHeader:chartDataHeader andDelegator:self];
	[chartRequest release], chartRequest = nil;
	[chartDataHeader release], chartDataHeader = nil;
	[model release], model = nil;
	//NSLog(@"%@", [chartDataHeader getHeader]);
   // NSURL* reqUrl = [NSURL URLWithString:@"http://chart.googleapis.com/chart?chs=250x100&chd=t:60,40&cht=p3&chl=Hello %7C World"];
	NSURL* reqUrl = [NSURL URLWithString:[self createGoogleChartURLString]];

	/*
	NSMutableString* urlString = [NSMutableString stringWithString:@"http://chart.apis.google.com/chart?chd=t:_30, -30, 50, 80, 200"];
	
    [urlString replaceOccurrencesOfString:@"|" withString:@"%7C" options:NSLiteralSearch range:NSRangeFromString(urlString)];
	NSURL* reqUrl = [NSURL URLWithString:urlString];
	//[reqUrl standardizedURL];
	*/
	NSURLRequest* req = [[NSURLRequest alloc] initWithURL:reqUrl];
	[[NSURLConnection alloc] initWithRequest:req delegate:self];
    [req	release], req = nil;
	
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
	[imageData release], imageData = nil;
	[model release], model = nil;
	[chartView release], chartView = nil;
	[chartTableView release], chartTableView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark request delegator

-(void)modelFinished:(RadrModel*)aModel {
	model = aModel;
	[model retain];
}

-(void)error: (RadrReqest*)aRequest description:(NSString*)aDescription {
	
	[aRequest release];
}

#pragma mark -
#pragma mark chart connnection delegator
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[imageData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	UIImage* img = [UIImage imageWithData:imageData];
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docDir = [paths objectAtIndex:0];
	NSString* writePath = [NSString stringWithFormat:@"%@/x.png", docDir];
	NSLog(@"%@", writePath);
	[imageData writeToFile:writePath atomically:YES];
	[chartView setImage:img];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
	NSLog(@"%@", [error description]);
}
@end
