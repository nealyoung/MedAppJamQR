//
//  MainViewController.h
//  MedAppJamQR
//
//  Created by Nealon Young on 11/11/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Event.h"

@interface MainViewController : UITableViewController

@property UISegmentedControl *appointmentTypePicker;

- (void)setSelectedTreatmentName:(NSString *)name id:(NSInteger)treatmentID typeName:(EventType)treatmentType;

@end
