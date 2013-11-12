//
//  TextViewCell.m
//  MedAppJamQR
//
//  Created by Nealon Young on 7/20/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (id)init {
    self = [super init];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSLog(@"%f", CGRectGetWidth(self.contentView.frame));
        
        self.tintColor = [UIColor colorWithRed:0xED/255.0 green:0x7A/255.0 blue:0x5D/255.0 alpha:1.0f];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 40)];
        self.label.textColor = [UIColor darkGrayColor];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.label];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 620, self.contentView.frame.size.height - 20)];
        self.textField.font = [UIFont systemFontOfSize:16];
        self.textField.placeholder = @"Text Field";
        self.textField.textColor = [UIColor darkGrayColor];
        self.textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
