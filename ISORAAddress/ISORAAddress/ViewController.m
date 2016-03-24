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
    RLMResults* userResult;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isWork = YES;
    isContacts = NO;
    isImpotant = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpInterFace];
    
    userResult = [UserEntity allObjects];
    _tableViewAddress.delegate = self;
    _tableViewAddress.dataSource = self;
    
    [_tableViewAddress registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressTableViewCell"];
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
#pragma mark - UICollectionView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell = (AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"addressTableViewCell"];
    [cell setDataWithUser:[userResult objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    CardsetDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"CardsetDetailViewController"];
//    Cardset* cardsetEntity = [cardsetList objectAtIndex:indexPath.row];
//    RLMResults<Card*>* cardsList = [Card objectsInRealm:realm where:@"cardset_id = %d",cardsetEntity.cardset_id];
//    controller.cardsetData = cardsetEntity;
//    controller.cardsData = cardsList;
//    
//    [self.navigationController pushViewController:controller animated:YES];
    
    NSLog(@"user selected!");
}

@end
