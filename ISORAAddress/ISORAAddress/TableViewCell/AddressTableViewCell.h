//
//  AddressTableViewCell.h
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
-(void)setDataWithUser:(UserEntity*) user;
@end
