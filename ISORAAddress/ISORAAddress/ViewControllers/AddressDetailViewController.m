//
//  AddressDetailViewController.m
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/25/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import "AddressDetailViewController.h"

@interface AddressDetailViewController ()

@end

@implementation AddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setData{
    _lblName.text = _user.name;
    _lblTitle.text = [NSString stringWithFormat:@"%@ - %@", _user.title, _user.groupName];
    _lblYearOfBirth.text = [NSString stringWithFormat:@"Năm sinh: %@", _user.year];
    
    @try {
        NSString *firstSectionOfNumber = [NSString stringWithFormat:@"0%@",[_user.phone substringWithRange:NSMakeRange(0,3)]];
        NSString *secondSectionOfNumber = [NSString stringWithFormat:@" %@",[_user.phone substringWithRange:NSMakeRange(3,3)]];
        NSString *thirdSectionOfNumber = [NSString stringWithFormat:@" %@",[_user.phone substringWithRange:NSMakeRange(6,3)]];
        _lblPhoneNumber.text = [NSString stringWithFormat:@"%@%@%@", firstSectionOfNumber, secondSectionOfNumber, thirdSectionOfNumber];
    }
    @catch (NSException *exception) {
        _lblPhoneNumber.text = INVALIDPHONENUMBER;
    }
    @finally {
        NSString *firstSectionOfNumber = [NSString stringWithFormat:@"0%@",[_user.phone substringWithRange:NSMakeRange(0,3)]];
        NSString *secondSectionOfNumber = [NSString stringWithFormat:@" %@",[_user.phone substringWithRange:NSMakeRange(3,3)]];
        NSString *thirdSectionOfNumber = [NSString stringWithFormat:@" %@",[_user.phone substringWithRange:NSMakeRange(6,3)]];
        _lblPhoneNumber.text = [NSString stringWithFormat:@"%@%@%@", firstSectionOfNumber, secondSectionOfNumber, thirdSectionOfNumber];
    }
    
    _lblEmail.text = _user.email;
    
    if (_user.isFavorite) {
        [_btnFavorite setImage:[UIImage imageNamed:@"favourite_yellow.png"] forState:UIControlStateNormal];
    }
    else{
        [_btnFavorite setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)favoriteButtonAction:(id)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if (_user.isFavorite) {
        _user.isFavorite = NO;
    }else{
        _user.isFavorite = YES;
    }
    [UserEntity createOrUpdateInRealm:realm withValue:_user];
    [realm commitWriteTransaction];
    
    if (_user.isFavorite) {
        [sender setImage:[UIImage imageNamed:@"favourite_yellow.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
