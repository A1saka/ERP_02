////
////  NSDictionary+NSDictionary.m
////  ERP_02
////
////  Created by Skylab on 16/11/3.
////  Copyright © 2016年 Skylab. All rights reserved.
////
//
#import "NSDictionary+NSDictionary.h"

@implementation NSDictionary (NSDictionary)
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
@end
