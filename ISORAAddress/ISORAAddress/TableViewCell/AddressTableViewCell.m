//
//  AddressTableViewCell.m
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import "AddressTableViewCell.h"

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
    _lblPhoneNumber.text = user.phone;
}
@end
