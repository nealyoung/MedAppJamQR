//
//  DatePickerCell.m
//  MedAppJamQR
//
//  Created by Nealon Young on 11/19/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "DatePickerCell.h"

#import "UIFont+Application.h"

@implementation DatePickerCell

- (id)init {
    self = [super init];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont mediumApplicationFontOfSize:16.0f];
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.datePicker];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.datePicker.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 320.0f, 0, 300.0f, 150.0f);
}

@end
