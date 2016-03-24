//
//  DepartmentEntity.h
//  ISORAAddress
//
//  Created by Ho Ngoc Thang on 3/24/16.
//  Copyright © 2016 Ho Ngoc Thang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface DepartmentEntity : RLMObject

@property NSInteger id;
@property NSString *name;
@property NSString *parent;

@end
