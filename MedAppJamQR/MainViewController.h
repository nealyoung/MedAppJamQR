//
//  MainViewController.h
//  MedAppJamQR
//
//  Created by Nealon Young on 11/11/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPOINTMENT_TYPE_SURGERY 0
#define APPOINTMENT_TYPE_IMAGING 1
#define APPOINTMENT_TYPE_LAB_TEST 2
#define APPOINTMENT_TYPE_ONCOLOGIST 3
#define APPOINTMENT_TYPE_CHEMO 4
#define APPOINTMENT_TYPE_RADIATION 5

@interface MainViewController : UITableViewController

@property UISegmentedControl *appointmentTypePicker;

@end
