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
    NSString *query;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isWork = YES;
    isContacts = NO;
    isImpotant = NO;
    _searchBar.delegate = self;
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
    [arrayHeaderWorks removeAllObjects];
        [arrayData removeAllObjects];
    
    for (int i = 0; i<userResult.count; i++) {
        UserEntity *entity = userResult[i];
        if (i == 0) {
            if (isWork) {
                [arrayHeaderWorks addObject:entity.groupName];
            }
            else{
                [arrayHeaderWorks addObject:[[entity.first_name substringToIndex:1] uppercaseString]];
            }
        }
        if (i != userResult.count - 1){
            UserEntity *nextEntity = userResult[i+1];
            if (isWork) {
                if (![entity.groupName isEqualToString:nextEntity.groupName]) {
                    [arrayHeaderWorks addObject:nextEntity.groupName];
                }
            }
            else{
                if (![arrayHeaderWorks containsObject:[[entity.first_name substringToIndex:1] uppercaseString]]) {
                    [arrayHeaderWorks addObject:[[entity.first_name substringToIndex:1] uppercaseString]];
                }
            }
        }
    }
    NSLog(@"%lu",(unsigned long)arrayHeaderWorks.count);
    NSLog(@"%@",arrayHeaderWorks);
    for (NSString *groupName in arrayHeaderWorks) {
        RLMResults *result;
        
        if (isWork) {
            if ([query isEqualToString:@""] || query == nil) {
                result = [UserEntity objectsWhere:[NSString stringWithFormat:@"groupName = '%@'",groupName]];
            }else{
                NSString *querry = [NSString stringWithFormat:@"(%@) AND groupName = '%@'",query,groupName];
                NSPredicate *pred = [NSPredicate predicateWithFormat:querry];
                result = [UserEntity objectsWithPredicate:pred];
            }
        }
        else if(isContacts){
            if ([query isEqualToString:@""] || query == nil) {
                NSLog(@"group name: %@", [groupName substringToIndex:1]);
                result = [UserEntity objectsWhere:[NSString stringWithFormat:@"first_name BEGINSWITH '%@'",[groupName substringToIndex:1]]];
            }else{
                NSString *querry = [NSString stringWithFormat:@"(%@) AND first_name BEGINSWITH '%@'",query,[groupName substringToIndex:1]];
                NSPredicate *pred = [NSPredicate predicateWithFormat:querry];
                result = [UserEntity objectsWithPredicate:pred];
            }
        }
        else{
            if ([query isEqualToString:@""] || query == nil) {
                result = [UserEntity objectsWhere:[NSString stringWithFormat:@"isFavorite == 1 AND first_name BEGINSWITH '%@'",[groupName substringToIndex:1]]];
            }else{
                NSString *querry = [NSString stringWithFormat:@"(%@) AND isFavorite == 1 AND first_name BEGINSWITH '%@'",query,[groupName substringToIndex:1]];
                NSPredicate *pred = [NSPredicate predicateWithFormat:querry];
                result = [UserEntity objectsWithPredicate:pred];
            }
        }
        
        [arrayData addObject:result];
    }
    [_tableViewAddress reloadData];
}
- (IBAction)actionWork:(id)sender {
    isWork = YES;
    isContacts = NO;
    isImpotant = NO;
    [self setUpInterFace];
    [self setUpDataForTable];
}
- (IBAction)actionContacts:(id)sender {
    isWork = NO;
    isContacts = YES;
    isImpotant = NO;
    [self setUpInterFace];
    [self setUpDataForTable];
}
- (IBAction)actionImpotant:(id)sender {
    isWork = NO;
    isContacts = NO;
    isImpotant = YES;
    [self setUpInterFace];
    [self setUpDataForTable];
}
#pragma mark - UICollectionView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray* arr = arrayHeaderWorks;
    return arrayHeaderWorks.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RLMResults *results = arrayData[section];
    return results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell = (AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"addressTableViewCell"];
    [cell setDataWithUser:arrayData[indexPath.section][indexPath.row]];
    
    //configure right buttons for cell
    UIImage *imgEmail = [self convertImageWithImage:[UIImage imageNamed:@"email_in_cell.png"] scaledToSize:CGSizeMake(80, 100)];
    UIImage *imgCall = [self convertImageWithImage:[UIImage imageNamed:@"call_in_cell.png"] scaledToSize:CGSizeMake(80, 100)];
    UIImage *imgMessage = [self convertImageWithImage:[UIImage imageNamed:@"message_in_cell.png"] scaledToSize:CGSizeMake(80, 100)];
    
    cell.rightButtons = @[
                          [MGSwipeButton buttonWithTitle:@"" icon:imgMessage backgroundColor:[UIColor clearColor] padding: 0 callback:^BOOL(MGSwipeTableCell * sender){
                              NSLog(@"message clicked");
                              [self messageInCellClicked:indexPath];
                              return YES; //autohide when clicked
                          }],
                          [MGSwipeButton buttonWithTitle:@"" icon:imgCall backgroundColor:[UIColor clearColor] padding: 0 callback:^BOOL(MGSwipeTableCell * sender){
                              NSLog(@"call clicked");
                              [self callInCellClicked:indexPath];
                              return YES; //autohide when clicked
                          }],
                          [MGSwipeButton buttonWithTitle:@"" icon:imgEmail backgroundColor:[UIColor clearColor] padding: 0 callback:^BOOL(MGSwipeTableCell * sender){
                              NSLog(@"email clicked");
                              [self emailInCellClicked:indexPath];
                              return YES; //autohide when clicked
                          }]];
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        return 0;
    } else {
        // whatever height you'd want for a real section header
        return 40;
    }
    
//    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderTableViewCell *headerCell =(HeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"headerTableViewCell"];
    [headerCell setData:arrayHeaderWorks[section]];
    
    return headerCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddressDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"addressDetailViewController"];
    UserEntity* userEntity = arrayData[indexPath.section][indexPath.row];
    
    controller.user = userEntity;
    NSLog(@"user selected!");
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)callInCellClicked:(NSIndexPath*) indexPath{
}
-(void)emailInCellClicked:(NSIndexPath*) indexPath{
}
-(void)messageInCellClicked:(NSIndexPath*) indexPath{
}
#pragma mark - convert image to size
-(UIImage *)convertImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark: - search bar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *searchText = [searchBar.text stringByTrimmingCharactersInSet:whitespace];
    if (searchText.length == 0) {
        searchBar.text = @"";
        return;
    }
    [arrayHeaderWorks removeAllObjects];
    [arrayData removeAllObjects];
    query = [NSString stringWithFormat:@"name CONTAINS[c] '%@' OR email CONTAINS[c] '%@' OR phone CONTAINS[c] '%@'",searchBar.text,searchBar.text,searchBar.text];
    NSPredicate *pred = [NSPredicate predicateWithFormat:query];
    userResult = [[UserEntity objectsWithPredicate:pred] sortedResultsUsingProperty:@"groupName" ascending:YES];
    [self setUpDataForTable];
    
      [searchBar resignFirstResponder];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *searchText = [searchBar.text stringByTrimmingCharactersInSet:whitespace];
    if (searchText.length == 0) {
        searchBar.text = @"";
        return;
    }
    [arrayHeaderWorks removeAllObjects];
    [arrayData removeAllObjects];
    query = [NSString stringWithFormat:@"name CONTAINS[c] '%@' OR email CONTAINS[c] '%@' OR phone CONTAINS[c] '%@'",searchBar.text,searchBar.text,searchBar.text];
    NSPredicate *pred = [NSPredicate predicateWithFormat:query];
    userResult = [[UserEntity objectsWithPredicate:pred] sortedResultsUsingProperty:@"groupName" ascending:YES];
    [self setUpDataForTable];
      [searchBar resignFirstResponder];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *searchText = [searchBar.text stringByTrimmingCharactersInSet:whitespace];
    if (searchText.length == 0) {
        searchBar.text = @"";
        return;
    }
    [arrayHeaderWorks removeAllObjects];
    [arrayData removeAllObjects];
    query = [NSString stringWithFormat:@"name CONTAINS[c] '%@' OR email CONTAINS[c] '%@' OR phone CONTAINS[c] '%@'",searchBar.text,searchBar.text,searchBar.text];
    NSPredicate *pred = [NSPredicate predicateWithFormat:query];
    userResult = [[UserEntity objectsWithPredicate:pred] sortedResultsUsingProperty:@"groupName" ascending:YES];
    [self setUpDataForTable];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [searchBar setShowsCancelButton:YES animated:YES];
    [arrayHeaderWorks removeAllObjects];
    [arrayData removeAllObjects];
    query = [NSString stringWithFormat:@"name CONTAINS[c] '%@' OR email CONTAINS[c] '%@' OR phone CONTAINS[c] '%@'",searchBar.text,searchBar.text,searchBar.text];
    NSPredicate *pred = [NSPredicate predicateWithFormat:query];
    userResult = [[UserEntity objectsWithPredicate:pred] sortedResultsUsingProperty:@"groupName" ascending:YES];
    [self setUpDataForTable];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *searchText = [searchBar.text stringByTrimmingCharactersInSet:whitespace];
    if (searchText.length == 0) {
        searchBar.text = @"";
        return;
    }
    [arrayHeaderWorks removeAllObjects];
    [arrayData removeAllObjects];
    userResult = [[UserEntity allObjects] sortedResultsUsingProperty:@"groupName" ascending:YES];
    [self setUpDataForTable];
    
    [searchBar resignFirstResponder];
}
@end
