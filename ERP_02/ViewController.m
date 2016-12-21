//
//  ViewController.m
//  ERP_02
//
//  Created by Skylab on 16/10/25.
//  Copyright © 2016年 Skylab. All rights reserved.
//

#import "ViewController.h"
#import "Scan_VC.h"
#import <MJExtension.h>
#import "PCresultModel.h"
#import <AFNetworking.h>
#import "PCcheckModel.h"



@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *eqNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *sizeButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *BillButton;
@property (weak, nonatomic) IBOutlet UIButton *realNumButton;
@property (weak, nonatomic) IBOutlet UIButton *riseonButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *destroyButton;
@property (weak, nonatomic) IBOutlet UIButton *placeButton;
@property (weak, nonatomic) IBOutlet UIButton *noteButton;

@property (nonatomic, strong) NSString *tag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ATGlobalBg;


}


- (void)viewDidAppear:(BOOL)animated
{
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:@"scannedResult" object:nil];

}
- (IBAction)oneClick:(id)sender
{

    UIButton *button = (UIButton *)sender;
    //取得button名称
//    NSString *mesage = [button currentTitle];
//    NSLog(@"%@",mesage);
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"请输入修改的数据"
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    // Alert配置信息
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //        textField.placeholder = @"";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    // 取消按钮
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alertController addAction:cancelAction];
    // 确定按钮
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
//        NSLog(@"%@",namefield.text);
        // 设置Button的Title
        [button setTitle:namefield.text forState:UIControlStateNormal];
//        NSString *mesage2 = [button currentTitle];
//        NSLog(@"%@",mesage2);
    
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}


#pragma mark - 扫描二维码
- (IBAction)scan:(id)sender
{
    Scan_VC *vc = [[Scan_VC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)show:(NSNotification *)notifaction
{
    // 将二维码数据显示
    NSString *scannedResult = notifaction.object;
    NSDictionary *dict = [NSDictionary dictionaryWithJsonString:scannedResult];
//    NSLog(@"%@",dict);
    PCresultModel *re1 = [PCresultModel mj_objectWithKeyValues:dict];
    
    self.tag = re1.id;
    [self.eqNumberButton setTitle:re1.uid forState:UIControlStateNormal];
    [self.nameButton setTitle:re1.name forState:UIControlStateNormal];
    [self.sizeButton setTitle:re1.size forState:UIControlStateNormal];
    [self.timeButton setTitle:re1.time forState:UIControlStateNormal];
    [self.BillButton setTitle:re1.price forState:UIControlStateNormal];
    [self.realNumButton setTitle:re1.Qsum forState:UIControlStateNormal];
    [self.riseonButton setTitle:re1.rise forState:UIControlStateNormal];
    [self.downButton setTitle:re1.down forState:UIControlStateNormal];
    [self.destroyButton setTitle:re1.scrap forState:UIControlStateNormal];
    [self.placeButton setTitle:re1.address forState:UIControlStateNormal];
    [self.noteButton setTitle:re1.notice forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - 检测
- (IBAction)checkResult:(id)sender
{
//    http://api.budejie.com/api/api_open.php
//    http://58.154.51.174/123/test.php
//    NSLog(@"%@",self.eqNumberButton.titleLabel.text);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"]  = self.tag;
    params[@"uid"] = self.eqNumberButton.titleLabel.text;
    params[@"name"] = self.nameButton.titleLabel.text;
    params[@"size"] = self.sizeButton.titleLabel.text;
    params[@"time"] = self.timeButton.titleLabel.text;
    params[@"price"] = self.BillButton.titleLabel.text;
    params[@"Qsum"] = self.realNumButton.titleLabel.text;
    params[@"address"] = self.placeButton.titleLabel.text;
    params[@"notice"] = self.noteButton.titleLabel.text;
    params[@"rise"] = self.riseonButton.titleLabel.text;
    params[@"down"] = self.downButton.titleLabel.text;
    params[@"scrap"] = self.destroyButton.titleLabel.text;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"]; 
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
// http://58.154.51.174/123/Eqtest.php
    [manager POST:@"http://58.154.51.174/123/Eqtest.php" parameters:params  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON:%@",responseObject);
        // JSON->模型
        PCcheckModel *message = [PCcheckModel mj_objectWithKeyValues:responseObject];
        NSLog(@"%@",message.message);
            
        // Alert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message.message  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@",error);
    }
     
     ];
    
    
}

#pragma mark - 上传
- (IBAction)update:(id)sender
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"警告"
                                                                              message: @"请确认信息正确后上传，点击确认继续"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
    {

    }];
    
    [alertController addAction:cancelAction];
    // 确定按钮
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * actio){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        //    NSLog(@"%@",self.eqNumberButton.titleLabel.text);
        params[@"uid"] = self.eqNumberButton.titleLabel.text;
        params[@"name"] = self.nameButton.titleLabel.text;
        params[@"size"] = self.sizeButton.titleLabel.text;
        params[@"time"] = self.timeButton.titleLabel.text;
        params[@"price"] = self.BillButton.titleLabel.text;
        params[@"Qsum"] = self.realNumButton.titleLabel.text;
        params[@"address"] = self.placeButton.titleLabel.text;
        params[@"notice"] = self.noteButton.titleLabel.text;
        params[@"rise"] = self.riseonButton.titleLabel.text;
        params[@"down"] = self.downButton.titleLabel.text;
        params[@"scrap"] = self.destroyButton.titleLabel.text;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // http://58.154.51.174/123/Eqtest.php
        [manager POST:@"http://58.154.51.174/123/upload.php" parameters:params  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"JSON:%@",responseObject);
            // JSON->模型
            PCcheckModel *message = [PCcheckModel mj_objectWithKeyValues:responseObject];
            NSLog(@"%@",message.message);
            
            // Alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message.message  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:defaultAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error:%@",error);
        }
         
         ];
    
    
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    
}


@end
