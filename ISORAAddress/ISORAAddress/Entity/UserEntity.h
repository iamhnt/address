//
//  UserEntity.h
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/24/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface UserEntity : RLMObject
@property NSInteger id;
@property NSString *name;
@property NSString *icon;
@property NSString *title;
@property NSString *groupName;
@property NSString *year;
@property NSString *email;
@property NSString *phone;
@property NSString *departmentId;
@end
