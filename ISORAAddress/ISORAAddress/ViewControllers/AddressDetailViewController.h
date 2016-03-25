//
//  AddressDetailViewController.h
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "Helper.h"

@interface AddressDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblYearOfBirth;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property(strong, nonatomic) UserEntity* user;
@end
