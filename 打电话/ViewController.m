//
//  ViewController.m
//  打电话
//
//  Created by 李攀祥 on 16/7/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ViewController.h"
#import "TelController.h"
#import "SMSController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * myTableView;
/** 数据源 */
@property (nonatomic,strong)NSArray * dataArr ;
/** 数据源2 */
@property (nonatomic,strong)NSArray * dataArr2;
/** 数据源3 */
@property (nonatomic,strong)NSArray * dataArr3;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];    
    self.dataArr= @[@"发短信",@"打电话",@"跳转到Safir"];
    self.dataArr2= @[@"跳转到WiFi",@"蓝牙",@"通用",@"关于",@"定位服务",@"通知"];
    self.dataArr3= @[@"WIFI",@"Bluetooth",@"General",@"General&path=About",@"LOCATION_SERVICES",@"NOTIFICATIONS_ID"];
    [self.view addSubview:self.myTableView];
}

-(UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain ];
        
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        
        _myTableView.showsVerticalScrollIndicator= NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.tableFooterView=[UIView new];
        
    }
    return _myTableView;
}

#pragma mark ---- UITableViewDelegate 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.dataArr.count;
    }else{
        return self.dataArr2.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellID = @"CellName";
        //2.根据可重用表示，到tableView得重用池子中，取cell对象
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        //3.如果取不到，则重新创建新的cell对象,并设置样式，且给cell赋值可重用标识
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell.textLabel.text = self.dataArr[indexPath.row];
        return cell;
    }else{
        static NSString *cellID = @"CellN";
        //2.根据可重用表示，到tableView得重用池子中，取cell对象
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        //3.如果取不到，则重新创建新的cell对象,并设置样式，且给cell赋值可重用标识
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell.textLabel.text = self.dataArr2[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        NSString * str =[NSString stringWithFormat:@"prefs:root=%@",self.dataArr3[indexPath.row]];
        [[UIApplication sharedApplication]
         openURL:[NSURL URLWithString:str]];
    }else{
        if (indexPath.row==1) {
            TelController * tel = [[TelController alloc] init];
            [self presentViewController:tel animated:YES completion:nil];
        }
        if (indexPath.row==0) {
            SMSController * sms =[[SMSController alloc] init];
            [self presentViewController:sms animated:YES completion:nil];
        }else if(indexPath.row==2){
         //4.调用Safari浏览器功能(在开发中遇到应用内打开网页的需求,建议使用UIWebView打开)
                if ([[UIApplication sharedApplication]
                     canOpenURL:[NSURL URLWithString:@"http://www.baidu.com/"]])
                {
                    [[UIApplication sharedApplication]
                     openURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
                }
            
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
