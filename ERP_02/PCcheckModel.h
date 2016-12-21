//
//  PCcheckModel.h
//  ERP_02
//
//  Created by LustXcc on 2016/11/13.
//  Copyright © 2016年 Skylab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCcheckModel : NSObject
/* message */
@property (nonatomic, copy) NSString *message;
/* id */
@property (nonatomic, copy) NSString *id;
/* code */
@property (nonatomic, assign) NSInteger *code;
@end
