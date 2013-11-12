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
    
    UIImage *qr = [QRCodeGenerator qrImageForString:@"Sample Text" imageSize:512.0f];
    UIImageView *qrView = [[UIImageView alloc] initWithImage:qr];
    qrView.frame = CGRectMake(0.0f, 0.0f, 512.0f, 512.0f);
    qrView.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0f, CGRectGetHeight([UIScreen mainScreen].bounds) / 2.0f);
    qrView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:qrView];

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)appointmentTypeChanged {
    NSLog(@"%d", self.appointmentTypePicker.selectedSegmentIndex);
}

- (void)submitButtonPressed {
    NSLog(@"Submit button pressed");
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
