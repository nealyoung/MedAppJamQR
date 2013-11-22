//
//  CategoriesViewController.m
//  MedAppJamQR
//
//  Created by Nealon Young on 11/20/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "CategoriesViewController.h"

#import "TreatmentsViewController.h"
#import "UIFont+Application.h"

@interface CategoriesViewController ()

@property NSArray *categories;

@end

@implementation CategoriesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        NSString *treatmentDataPath = [[NSBundle mainBundle] pathForResource:@"TreatmentData" ofType:@"plist"];
        NSDictionary *treatmentData = [[NSDictionary alloc] initWithContentsOfFile:treatmentDataPath];
        
        self.categories = [treatmentData allKeys];
        self.categories = [self.categories sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Appointment Type";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.categories[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TreatmentsViewController *treatmentsViewController = [[TreatmentsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    NSString *treatmentDataPath = [[NSBundle mainBundle] pathForResource:@"TreatmentData" ofType:@"plist"];
    NSDictionary *treatmentData = [[NSDictionary alloc] initWithContentsOfFile:treatmentDataPath];
    NSArray *treatments = treatmentData[self.categories[indexPath.row]];
    
    NSString *eventTypeString = self.categories[indexPath.row];
    EventType eventType;
    
    if ([eventTypeString isEqualToString:@"Chemotherapy"]) {
        eventType = EventTypeChemo;
    } else if ([eventTypeString isEqualToString:@"Imaging"]) {
        eventType = EventTypeImaging;
    } else if ([eventTypeString isEqualToString:@"Lab Test"]) {
        eventType = EventTypeLabTest;
    } else if ([eventTypeString isEqualToString:@"Radiation"]) {
        eventType = EventTypeRadiation;
    } else {
        eventType = EventTypeSurgery;
    }
    
    treatmentsViewController.treatments = treatments;
    treatmentsViewController.eventType = eventType;
    [self.navigationController pushViewController:treatmentsViewController animated:YES];
}

@end
