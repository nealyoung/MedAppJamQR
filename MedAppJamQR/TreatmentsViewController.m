//
//  TreatmentsViewController.m
//  MedAppJamQR
//
//  Created by Nealon Young on 11/21/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "TreatmentsViewController.h"

#import "MainViewController.h"

@interface TreatmentsViewController ()

@end

@implementation TreatmentsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        
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
    return [self.treatments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *treatment = self.treatments[indexPath.row];
    cell.textLabel.text = treatment[@"ProcedureName"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *navigationViewControllers = self.navigationController.viewControllers;
    MainViewController *mainViewController = (MainViewController *)navigationViewControllers[0];
    NSDictionary *treatment = self.treatments[indexPath.row];

    [mainViewController setSelectedTreatmentName:treatment[@"ProcedureName"] id:indexPath.row typeName:self.eventType];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end