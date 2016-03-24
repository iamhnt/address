//
//  ViewController.h
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/24/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "UserEntity.h"
#import "DepartmentEntity.h"
#import "AddressTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbUnderLineWork;
@property (weak, nonatomic) IBOutlet UILabel *lbUnderContacts;
@property (weak, nonatomic) IBOutlet UILabel *lbUnderLineImpotant;
@property (weak, nonatomic) IBOutlet UITableView *tableViewAddress;


@end

