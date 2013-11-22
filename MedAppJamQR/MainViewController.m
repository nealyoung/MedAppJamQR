//
//  MainViewController.m
//  MedAppJamQR
//
//  Created by Nealon Young on 11/11/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "MainViewController.h"

#import "CategoriesViewController.h"
#import "DatePickerCell.h"
#import "TextFieldCell.h"
#import "QRCodeGenerator.h"
#import "UIFont+Application.h"

#define APPOINTMENT_ROW 0
#define OFFICE_ROW 1
#define ADDRESS_ROW 2
#define CITY_STATE_ZIP_ROW 3
#define DATE_PICKER_ROW 4

@interface MainViewController ()

@property NSInteger selectedTreatmentType;
@property NSInteger selectedTreatmentID;

- (void)appointmentTypeChanged;
- (void)generateCode;

@end

static NSString *AppointmentTypeCellIdentifier = @"AppointmentTypeCell";
static NSString *TextFieldCellIdentifier = @"TextFieldCell";

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.scrollEnabled = NO;
        self.selectedTreatmentID = 0;
        self.selectedTreatmentType = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Schedule Appointment";

    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitButton setTitle:@"Generate Code" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont mediumApplicationFontOfSize:34.0f];
    submitButton.frame = CGRectMake(0, 0, 300, 100);
    submitButton.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0f, 420.0f);
    submitButton.tintColor = [UIColor darkGrayColor];
    [submitButton addTarget:self action:@selector(generateCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    self.appointmentTypePicker = [[UISegmentedControl alloc] initWithItems:@[@"Surgery", @"Chemotherapy", @"Radiation"]];
    self.appointmentTypePicker.selectedSegmentIndex = 0;
    [self.appointmentTypePicker sizeToFit];
    [self.appointmentTypePicker addTarget:self action:@selector(appointmentTypeChanged) forControlEvents:UIControlEventValueChanged];
    
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
- (void)generateCode {
    TextFieldCell *officeCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:OFFICE_ROW inSection:0]];
    NSString *officeString = officeCell.textField.text;
    
    TextFieldCell *addressCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ADDRESS_ROW inSection:0]];
    NSString *addressString = addressCell.textField.text;
    
    TextFieldCell *cityCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:CITY_STATE_ZIP_ROW inSection:0]];
    NSString *cityString = cityCell.textField.text;
    
    DatePickerCell *datePickerCell = (DatePickerCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:DATE_PICKER_ROW inSection:0]];
    NSDate *date = datePickerCell.datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *json = [NSString stringWithFormat:@"{ \"EventType\"   : %d,\
                                                    \"TreatmentID\" : %d,\
                                                    \"Date\"        : \"%@\",\
                                                    \"Location\"    : \"%@\\n%@\\n%@\" }", self.selectedTreatmentType, self.selectedTreatmentID, dateString, officeString, addressString, cityString];
    
    NSLog(@"%@", json);
    
    // Create a generic view controller, push it onto the navigation stack, and add the generated qr code as a subview
    UIViewController *qrViewController = [[UIViewController alloc] init];
    qrViewController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImage *qrCode = [QRCodeGenerator qrImageForString:json imageSize:512.0f];
    UIImageView *qrCodeView = [[UIImageView alloc] initWithImage:qrCode];
    qrCodeView.center = qrViewController.view.center;
    
    [qrViewController.view addSubview:qrCodeView];
    
    [self.navigationController pushViewController:qrViewController animated:YES];
}

- (void)setSelectedTreatmentName:(NSString *)name id:(NSInteger)treatmentID typeName:(EventType)treatmentType {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    cell.detailTextLabel.text = name;
    
    NSLog(@"%@ %d %d", name, treatmentID, treatmentType);;

    self.selectedTreatmentID = treatmentID;
    self.selectedTreatmentType = treatmentType;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CategoriesViewController *categoriesViewController = [[CategoriesViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:categoriesViewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == DATE_PICKER_ROW) {
        return 160.0f;
    }
    
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == APPOINTMENT_ROW) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppointmentTypeCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AppointmentTypeCellIdentifier];
            cell.textLabel.text = @"Appointment Type";
            cell.textLabel.font = [UIFont mediumApplicationFontOfSize:16.0f];
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
    } else if (indexPath.row == OFFICE_ROW) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
        
        if (cell == nil) {
            cell = [[TextFieldCell alloc] init];
            cell.textLabel.text = @"Provider";
            cell.textField.placeholder = @"UCI Medical Center";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else if (indexPath.row == ADDRESS_ROW) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
        
        if (cell == nil) {
            cell = [[TextFieldCell alloc] init];
            cell.textLabel.text = @"Office Address";
            cell.textField.placeholder = @"101 The City Dr. South";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else if (indexPath.row == CITY_STATE_ZIP_ROW) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
        
        if (cell == nil) {
            cell = [[TextFieldCell alloc] init];
            cell.textLabel.text = @"City, State, ZIP Code";
            cell.textField.placeholder = @"Orange, CA 98888";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else if (indexPath.row == DATE_PICKER_ROW) {
        DatePickerCell *dateCell = [[DatePickerCell alloc] init];
        dateCell.textLabel.text = @"Date & Time";
        return dateCell;
    }
    
    return nil;
}

@end
