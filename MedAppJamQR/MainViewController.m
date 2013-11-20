//
//  MainViewController.m
//  MedAppJamQR
//
//  Created by Nealon Young on 11/11/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "MainViewController.h"

#import "TextFieldCell.h"
#import "QRCodeGenerator.h"
#import "UIFont+Application.h"

@interface MainViewController ()

- (void)appointmentTypeChanged;
- (void)submitButtonPressed;

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *qrImage = [QRCodeGenerator qrImageForString:@"Sample Text" imageSize:512.0f];
    self.qrImageView = [[UIImageView alloc] initWithImage:qrImage];
    self.qrImageView.frame = CGRectMake(0.0f, 0.0f, 512.0f, 512.0f);
    self.qrImageView.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0f, CGRectGetHeight([UIScreen mainScreen].bounds) / 2.0f);
    self.qrImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.qrImageView];

    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont mediumApplicationFontOfSize:34.0f];
    submitButton.frame = CGRectMake(0, 0, 200, 100);
    submitButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0f, CGRectGetHeight([UIScreen mainScreen].bounds) - 200.0f);
    submitButton.tintColor = [UIColor darkGrayColor];
    [submitButton addTarget:self action:@selector(submitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    self.appointmentTypePicker = [[UISegmentedControl alloc] initWithItems:@[@"Surgery", @"Chemotherapy", @"Radiation"]];
    self.appointmentTypePicker.selectedSegmentIndex = 0;
    [self.appointmentTypePicker sizeToFit];
    [self.appointmentTypePicker addTarget:self action:@selector(appointmentTypeChanged) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.appointmentTypePicker;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)appointmentTypeChanged {
    NSLog(@"%d", self.appointmentTypePicker.selectedSegmentIndex);
}

/*
 Format for QR code:
 
 {
 "EventType" : Integer EventType value,
 "Date" : Date and time of appointment, in a string formatted with NSDateFormatterLongStyle
 "Location" : "Medical Clinic\n123 Main St.\nIrvine, CA 92617"
 "TreatmentID" : Integer index to array of treatments for specified event type
 }
 */
- (void)submitButtonPressed {
    //`TextFieldCell *cell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //self.qrImageView.image = [QRCodeGenerator qrImageForString:cell.textField.text imageSize:512.0f];
    
    NSString *json = @"{ \"EventType\"   : 2,\
                         \"TreatmentID\" : 0,\
                         \"Date\"        : \"November 27, 2013 at 3:47:27 PM PST\",\
                         \"Location\"    : \"OC Oncology\\n123 Fake St. South\\nOrange, CA 98888\" }";
    
    self.qrImageView.image = [QRCodeGenerator qrImageForString:json imageSize:512.0f];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TextFieldCellIdentifier = @"Cell";
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
    
    if (cell == nil) {
        cell = [[TextFieldCell alloc] init];
        cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
