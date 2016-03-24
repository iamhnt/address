//
//  AddressTableViewCell.m
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "Helper.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataWithUser:(UserEntity*) user{
    _lblName.text = user.name;
    _lblPosition.text = user.title;
    _lblEmail.text = user.email;
    
    @try {
        NSString *firstSectionOfNumber = [NSString stringWithFormat:@"0%@",[user.phone substringWithRange:NSMakeRange(0,3)]];
        NSString *secondSectionOfNumber = [NSString stringWithFormat:@" %@",[user.phone substringWithRange:NSMakeRange(3,3)]];
        NSString *thirdSectionOfNumber = [NSString stringWithFormat:@" %@",[user.phone substringWithRange:NSMakeRange(6,3)]];
        _lblPhoneNumber.text = [NSString stringWithFormat:@"%@%@%@", firstSectionOfNumber, secondSectionOfNumber, thirdSectionOfNumber];
    }
    @catch (NSException *exception) {
        _lblPhoneNumber.text = INVALIDPHONENUMBER;
    }
    @finally {
        NSString *firstSectionOfNumber = [NSString stringWithFormat:@"0%@",[user.phone substringWithRange:NSMakeRange(0,3)]];
        NSString *secondSectionOfNumber = [NSString stringWithFormat:@" %@",[user.phone substringWithRange:NSMakeRange(3,3)]];
        NSString *thirdSectionOfNumber = [NSString stringWithFormat:@" %@",[user.phone substringWithRange:NSMakeRange(6,3)]];
        _lblPhoneNumber.text = [NSString stringWithFormat:@"%@%@%@", firstSectionOfNumber, secondSectionOfNumber, thirdSectionOfNumber];
    }
}
@end
