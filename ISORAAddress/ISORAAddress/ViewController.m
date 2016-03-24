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
  NSMutableArray *arrayHeaderWorks;
  NSMutableArray *arrayData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  isWork = YES;
  isContacts = NO;
  isImpotant = NO;
  arrayData = [[NSMutableArray alloc]init];
  arrayHeaderWorks = [[NSMutableArray alloc]init];
  userResult = [[UserEntity allObjects] sortedResultsUsingProperty:@"groupName" ascending:YES];

  // Do any additional setup after loading the view, typically from a nib.
  [self setUpInterFace];
  [self setUpDataForTable];
  _tableViewAddress.delegate = self;
  _tableViewAddress.dataSource = self;
  [_tableViewAddress registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"headerTableViewCell"];
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
-(void)setUpDataForTable{
  for (int i = 0; i<userResult.count; i++) {
    UserEntity *entity = userResult[i];
    if (i == 0) {
      [arrayHeaderWorks addObject:entity.groupName];
    }
    if (i != userResult.count - 1){
      UserEntity *nextEntity = userResult[i+1];
      if (![entity.groupName isEqualToString:nextEntity.groupName]) {
        [arrayHeaderWorks addObject:nextEntity.groupName];
      }
    }
  }
  NSLog(@"%d",arrayHeaderWorks.count);
  for (NSString *groupName in arrayHeaderWorks) {
    RLMResults *result = [UserEntity objectsWhere:[NSString stringWithFormat:@"groupName = '%@'",groupName]];
    [arrayData addObject:result];
  }
  [_tableViewAddress reloadData];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return arrayHeaderWorks.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  RLMResults *results = arrayData[section];
  return results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  AddressTableViewCell *cell = (AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"addressTableViewCell"];
  [cell setDataWithUser:arrayData[indexPath.section][indexPath.row]];
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  HeaderTableViewCell *headerCell =(HeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"headerTableViewCell"];
  [headerCell setData:arrayHeaderWorks[section]];
  return headerCell;
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
