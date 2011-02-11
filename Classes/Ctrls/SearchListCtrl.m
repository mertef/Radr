//
//  SearchListCtrl.m
//  RadrApp
//
//  Created by zhangdong on 1/24/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "SearchListCtrl.h"
#import "RadrModel.h"
#import "ResponseObject.h"
#import "Listing.h"
#import "SearchListCtrlCell.h"
#import "SearchedLocationAnnotation.h"
#import "Location.h"
#import "Config.h"
#include "SearchChartCtrl.h"

#define MAX_TIME 10
@implementation SearchListCtrl
@synthesize model;
@synthesize utilTools;
@synthesize locationMapView;
@synthesize tableViewList;
@synthesize locationManager;
@synthesize userLocation;
@synthesize floatView;
@synthesize filterBtn, avgBtn;

@synthesize mapListSegmented;
#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style  andModel: (RadrModel* )aModel{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithNibName:@"FloatWigit" bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization.
		self.model = aModel;		
        
		//UISegmentedControl* utilTools = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 240.0f, 40.0f)];
		utilTools = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 210.0f, 60.0f)];
		UIBarButtonItem* mapBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Map", @"map") style:UIBarButtonItemStyleDone target:self action:@selector(mapView:)];
		UIBarButtonItem* listBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"List", @"map") style:UIBarButtonItemStyleDone target:self action:@selector(listView:)];
		UIBarButtonItem* currentlocationBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"My Location", @"map") style:UIBarButtonItemStyleDone target:self action:@selector(currentLocation:)];

				
		NSArray* items = [NSArray arrayWithObjects:
						  mapBar, listBar, currentlocationBar, nil
						  ];
		[mapBar release], [listBar release];[currentlocationBar release],currentlocationBar = nil;
		[utilTools setItems:items];
		/*
		CGRect titleFrame = self.navigationItem.titleView.bounds;
		titleFrame.size.width += 30.0f;
		self.navigationItem.titleView.frame = titleFrame;
		[self.navigationItem setTitleView: utilTools];
		*/
		[self.navigationItem setTitleView: utilTools];
		locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		userLocation = nil;
		isMapLoaded = NO;
		isUpdateing = NO;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:CONST_REFRESH object:nil];
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle
- (void)loadView { // This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
    [super loadView];	
}


- (void)viewDidLoad {
    [super viewDidLoad];
	tableViewList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	tableViewList.delegate = self;
	tableViewList.dataSource = self;
	[self.view addSubview: tableViewList];	

	locationMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	locationMapView.hidden = YES;
	locationMapView.delegate = self;
	locationMapView.mapType = MKMapTypeStandard;
	MKCoordinateRegion region = locationMapView.region;
	//region.span = MKCoordinateSpanMake(1.0f, 1.0f);
	Location* l = [model.response.locations objectAtIndex:0];
	//NSLog(@"latitude is %f, and longtitude is %f", [l center_lat], [l center_long]);
    CLLocationCoordinate2D c2d = {l.center_lat, l.center_long};
	region.center = c2d;
	region.span.latitudeDelta = 1.0f;
	region.span.longitudeDelta = 1.0f;
	
	[locationMapView setRegion:region animated: YES];
	[locationMapView regionThatFits:region];
	
	

	
    
	for (Listing* list in self.model.response.listings) {
		CLLocationCoordinate2D c2d;
		c2d.latitude = list.latitude;
		c2d.longitude = list.longitude;
		NSLog(@"latitude is %f, and longtitude is %f", list.latitude, list.longitude);
		SearchedLocationAnnotation* sla = [[SearchedLocationAnnotation alloc] initWithCoordinate:c2d title:list.title subTitle:list.keywords];
		sla.longTitle = list.summary;
		[locationMapView addAnnotation: sla];
		[sla release], sla = nil;
	}
	[self.view addSubview: locationMapView];
	[self.view addSubview: floatView];
	/*
	geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:region.center];
	geoCoder.delegate=self;
	[geoCoder start];
	*/

	//[self.view addSubview:locationMapView];
	[self.view sendSubviewToBack:locationMapView];
	
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	[self.navigationController setNavigationBarHidden: YES];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	//[self.navigationController setNavigationBarHidden:YES];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSLog(@"table count is %u", [[[model response] listings] count]);
    return [[[model response] listings] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	Listing* list = [[[model response] listings] objectAtIndex:[indexPath row]];
	//NSLog(@"height is %u", [list thumb_height]);
    return (CGFloat)[list thumb_height];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellSearchList";
	Listing* list = [[[model response] listings] objectAtIndex:[indexPath row]];

	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SearchListCtrlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		CGRect cellRect = [cell frame];
		cellRect.size.height = (CGFloat)[list thumb_height];
		[cell setFrame:cellRect];
    }else {
		SearchListCtrlCell* searchCell = (SearchListCtrlCell*)cell;
		searchCell.price.text = [NSString stringWithFormat:@"%u", [list price]];
		searchCell.description.text = [list summary];
		searchCell.numberOfRooms.text = [list bedroom_number];
		searchCell.numberOfBatherooms.text = [list bathroom_number];
		/*
		UIImage* img = [[UIImage alloc] initWithData:[list thumb_img_data]];
		cell.imageView.image = img;
		[img release], img = nil;
		 */
	}

	
	
	
    // Configure the cell...
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[filterBtn release], filterBtn = nil;
	[avgBtn release], avgBtn = nil;
	[mapListSegmented release], mapListSegmented = nil;
	[floatView release], floatView = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[geoCoder release], geoCoder = nil;
	[locationManager release], locationManager = nil;
	[model release], model = nil;
	[utilTools release], utilTools = nil;
	[locationMapView release], locationMapView = nil;
	[tableViewList release], tableViewList = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark screen refresh
-(void)refresh:(id)aSender {
	[self.tableViewList reloadData];			 
}

#pragma mark -
#pragma mark switch views
-(void)mapView: (id)aSender {
	[self.view bringSubviewToFront:locationMapView];
	MKCoordinateRegion region = locationMapView.region;
	//region.span = MKCoordinateSpanMake(1.0f, 1.0f);
	Location* l = [model.response.locations objectAtIndex:0];
	NSLog(@"latitude is %f, and longtitude is %f", [l center_lat], [l center_long]);
    CLLocationCoordinate2D c2d = {l.center_lat, l.center_long};
	region.center = c2d;
	region.span.latitudeDelta = 0.25f;
	region.span.longitudeDelta = 0.25f;
	
	[locationMapView setRegion:region animated: YES];
	[locationMapView regionThatFits:region];
	
	locationMapView.hidden = NO;
	if(![locationManager locationServicesEnabled]) {
		UIAlertView* alert = [[UIAlertView alloc] 
						initWithTitle:NSLocalizedString(@"map_service_unavailabe", @"service not avaible!") 
						message:NSLocalizedString(@"Please enable your location service, or make sure your netwark connectivity is avaible!", @"map service not aviable")
						delegate:nil 
					    cancelButtonTitle:NSLocalizedString(@"Cancel", @"cancel") 
						otherButtonTitles:nil];
		[alert show];
		[alert release], alert = nil;
	}else {
		
	}

	
}

-(void)listView: (id)aSender {
	locationMapView.hidden = YES;
	[self.view sendSubviewToBack:locationMapView];
	[self.view bringSubviewToFront:tableViewList];
}

-(void)currentLocation: (id)aSender {
	[self.view bringSubviewToFront:locationMapView];
	locationMapView.hidden = NO;
	if(![locationManager locationServicesEnabled]) {
		UIAlertView* alert = [[UIAlertView alloc] 
							  initWithTitle:NSLocalizedString(@"map_service_unavailabe", @"service not avaible!") 
							  message:NSLocalizedString(@"Please enable your location service, or make sure your netwark connectivity is avaible!", @"map service not aviable")
							  delegate:nil 
							  cancelButtonTitle:NSLocalizedString(@"Cancel", @"cancel") 
							  otherButtonTitles:nil];
		[alert show];
		[alert release], alert = nil;
	}else {
		
	}
	if (!isUpdateing) {
		[locationManager startUpdatingLocation];
		[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
		locationMapView.zoomEnabled = NO;
		[self.view bringSubviewToFront:locationMapView];
		locationMapView.hidden = NO;
	}
	
}
#pragma mark map delegator
- (void)mapViewDidFailLoadingMap:(MKMapView *)aMapView withError:(NSError *)error {
	if (error) {
		NSLog(@"Error:%@", [error description]);
	}
}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation {
	MKPinAnnotationView* pinView = nil;
	static NSString* pinIdentifier = @"Pin";
	if ([annotation  isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}
	//CLLocationCoordinate2D l2d = [annotation coordinate];
   // NSLog(@"map view : %f, %f", l2d.latitude, l2d.longitude);
	if ([annotation isKindOfClass:[SearchedLocationAnnotation class]]) {
		//SearchedLocationAnnotation* sAnnotation = (SearchedLocationAnnotation*)annotation;
		//pinView = (MKPinAnnotationView*)[aMapView dequeueReusableAnnotationViewWithIdentifier:[sAnnotation title]];
		pinView = (MKPinAnnotationView*)[aMapView dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];

		//NSLog(@"annotation has been callled");
		if (!pinView) {
			pinView = [[[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier:pinIdentifier] autorelease];
			pinView.pinColor = MKPinAnnotationColorGreen;
			pinView.animatesDrop = YES;
			pinView.canShowCallout = YES;
			UIButton* rightButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
			//[rightButton addTarget:self action:@selector(myShowDetailsMethod:) forControlEvents:UIControlEventTouchUpInside];
			pinView.rightCalloutAccessoryView = rightButton;
			//pinView.centerOffset =  CGPointMake(10, -20);
			
		}
		pinView.annotation = annotation;
	}
		
	return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aAnnotationView {
	if ([aAnnotationView isKindOfClass:[MKPinAnnotationView class]]) {
		
		((MKPinAnnotationView*)aAnnotationView).pinColor = MKPinAnnotationColorRed;

	}
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)aAnnotationView {
	if ([aAnnotationView isKindOfClass:[MKPinAnnotationView class]]) {
		((MKPinAnnotationView*)aAnnotationView).pinColor = MKPinAnnotationColorGreen;
	}
}

#pragma mark -
#pragma mark cllocation delegator
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

	NSLog(@"user location update!");
	if (!userLocation) {
		self.userLocation = newLocation;
		return;
	}
	if (self.userLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
		self.userLocation = newLocation;
		locationMapView.region = MKCoordinateRegionMake( self.userLocation.coordinate, MKCoordinateSpanMake(0.1f, 0.1f));
		locationMapView.showsUserLocation = YES;
		locationMapView.zoomEnabled = NO;
	}
}

-(void)timerCount: (id)aSender {
	static int count = 0;
	
	if (count ++ > MAX_TIME) {
		[(NSTimer*)aSender invalidate];
		[locationManager stopUpdatingLocation];
		if (!userLocation) {
			return;
		}	
		
	    //CLLocationCoordinate2D cll2d = [userLocation coordinate];
		//NSLog(@"latitude is %f, and longtitude is %f", cll2d.latitude, cll2d.longitude);
		
		
		
		/*
		 CLLocationCoordinate2D cl2d = self.userLocation.coordinate;
		SearchedLocationAnnotation* userLocationAnnotation = [[SearchedLocationAnnotation alloc] initWithCoordinate:cl2d  title:@"I am here" subTitle:@"Me"];
        [locationMapView addAnnotation: userLocationAnnotation];
		[userLocationAnnotation release], userLocationAnnotation = nil;
		 */
		[locationMapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000.0f, 1000.0f) animated:YES];
		
		locationMapView.showsUserLocation = YES;
		locationMapView.zoomEnabled = YES;
		isUpdateing = NO;
	
	}else {
		isUpdateing = YES;
	}

}

#pragma mark -
#pragma mark geo reverse
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	
}
// There are at least two types of errors:
//   - Errors sent up from the underlying connection (temporary condition)
//   - Result not found errors (permanent condition).  The result not found errors
//     will have the domain MKErrorDomain and the code MKErrorPlacemarkNotFound
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	
}

#pragma mark -
#pragma mark float wigit
-(IBAction)filterBtnPressed: (id)aSender {
	
}

-(IBAction)avgBtnPressed: (id)aSender {
	SearchChartCtrl* chartCtl = [[SearchChartCtrl alloc] initWithMode: model];
	[self.navigationController pushViewController:chartCtl animated:YES];
	[chartCtl release], chartCtl = nil;
}

-(IBAction)mapListSegmentedValueChanged: (id)aSender {
    if(mapListSegmented.selectedSegmentIndex == 0) {
		[self mapView:nil];
	}else {
		[self listView:nil];
	}
    [self.view bringSubviewToFront:floatView ];
}

@end

