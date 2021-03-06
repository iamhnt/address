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
#import "HeaderTableViewCell.h"
#import "AddressDetailViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbUnderLineWork;
@property (weak, nonatomic) IBOutlet UILabel *lbUnderContacts;
@property (weak, nonatomic) IBOutlet UILabel *lbUnderLineImpotant;
@property (weak, nonatomic) IBOutlet UITableView *tableViewAddress;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

