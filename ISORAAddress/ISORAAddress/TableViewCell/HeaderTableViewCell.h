//
//  HeaderTableViewCell.h
//  ISORAAddress
//
//  Created by trong on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbGroupName;
-(void)setData:(NSString*)header;
@end
