//
//  HeaderTableViewCell.m
//  ISORAAddress
//
//  Created by trong on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSString *)header{
  _lbGroupName.text =header;
}
@end
