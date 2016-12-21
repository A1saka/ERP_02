//
//  PCresultModel.h
//  ERP_02
//
//  Created by Skylab on 16/11/3.
//  Copyright © 2016年 Skylab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCresultModel : NSObject
/* id */
@property (nonatomic, copy) NSString *id;
/** uid */
@property (nonatomic, copy) NSString *uid;
/** name */
@property (nonatomic, copy) NSString *name;
/* size */
@property (nonatomic, copy) NSString *size;
/* time */
@property (nonatomic, copy) NSString *time;
/* price */
@property (nonatomic, copy) NSString *price;
/* Qsun */
@property (nonatomic, copy) NSString *Qsum;
/* address */
@property (nonatomic, copy) NSString *address;
/* notice */
@property (nonatomic, copy) NSString *notice;
/* rise */
@property (nonatomic, copy) NSString *rise;
/* dowm */
@property (nonatomic, copy) NSString *down;
/* scrap */
@property (nonatomic, copy) NSString *scrap;
@end
