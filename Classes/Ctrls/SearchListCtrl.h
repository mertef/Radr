//
//  SearchListCtrl.h
//  RadrApp
//
//  Created by zhangdong on 1/24/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class RadrModel;
@interface SearchListCtrl : UIViewController<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate> {

	@private
	RadrModel* model;
	UIToolbar* utilTools;
	MKMapView* locationMapView;
	UITableView* tableViewList;
	Boolean   isMapLoaded;
	Boolean   isUpdateing;
	@protected
	CLLocationManager* locationManager;
    MKReverseGeocoder* geoCoder;
	CLLocation* userLocation;
	@protected
	IBOutlet UIView* floatView;
	IBOutlet UIButton* filterBtn, * avgBtn;
	IBOutlet UISegmentedControl* mapListSegmented;
}
@property(nonatomic, retain) RadrModel* model;
@property(nonatomic, retain) UIToolbar* utilTools;
@property(nonatomic, retain) MKMapView* locationMapView;
@property(nonatomic, retain) UITableView* tableViewList;

@property(nonatomic, retain) CLLocationManager* locationManager;
@property(nonatomic, retain) CLLocation* userLocation;
@property(nonatomic, retain) UIView* floatView;
@property(nonatomic, retain) UIButton* filterBtn, *avgBtn;
@property(nonatomic, retain) UISegmentedControl* mapListSegmented;

- (id)initWithStyle:(UITableViewStyle)style  andModel: (RadrModel* )aModel;
-(void)refresh:(id)aSender;
-(void)mapView: (id)aSender;
-(void)listView: (id)aSender;
-(void)currentLocation: (id)aSender;
-(void)timerCount: (id)aSender;

-(IBAction)filterBtnPressed: (id)aSender;
-(IBAction)avgBtnPressed: (id)aSender;
-(IBAction)filterBtnPressed: (id)aSender;
-(IBAction)mapListSegmentedValueChanged: (id)aSender;
@end
