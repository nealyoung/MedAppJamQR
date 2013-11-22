//
//  TreatmentsViewController.h
//  MedAppJamQR
//
//  Created by Nealon Young on 11/21/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface TreatmentsViewController : UITableViewController

@property EventType eventType;
@property NSArray *treatments;

@end
