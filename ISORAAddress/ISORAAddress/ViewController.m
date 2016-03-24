//
//  ViewController.m
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/24/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
  BOOL isWork,isContacts,isImpotant;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  isWork = YES;
  isContacts = NO;
  isImpotant = NO;
  [self setUpInterFace];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpInterFace{
  _lbUnderLineWork.hidden = !isWork;
  _lbUnderContacts.hidden = !isContacts;
  _lbUnderLineImpotant.hidden = !isImpotant;
}
- (IBAction)actionWork:(id)sender {
  isWork = YES;
  isContacts = NO;
  isImpotant = NO;
  [self setUpInterFace];
}
- (IBAction)actionContacts:(id)sender {
  isWork = NO;
  isContacts = YES;
  isImpotant = NO;
  [self setUpInterFace];
}
- (IBAction)actionImpotant:(id)sender {
  isWork = NO;
  isContacts = NO;
  isImpotant = YES;
  [self setUpInterFace];
}

@end
