//
//  TelController.m
//  打电话
//
//  Created by 李攀祥 on 16/7/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "TelController.h"

@interface TelController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSArray * dataArr ;

@end

@implementation TelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate= self;
    self.myTableView.dataSource=self;
    self.dataArr= @[@"推荐这一种",@"打电话（原来不能调回  现在可以跳回来）",@"这种最好不用 也许会上架不了",@"返回上一页"];
    
}

#pragma mark ---- 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString *cellID = @"CellName";
    //2.根据可重用表示，到tableView得重用池子中，取cell对象
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //3.如果取不到，则重新创建新的cell对象,并设置样式，且给cell赋值可重用标识
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text =self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        //1.这种 是最好的调用 打电话的方式（打完电话之后,会返回到app）（可以上架）
                         UIWebView *webView = [[UIWebView alloc] init];
                         [webView loadRequest:[NSURLRequest
                                              requestWithURL:
                                              [NSURL URLWithString:@"tel://10086"]]];
                         [self.view addSubview:webView];

    }else if (indexPath.row == 1){
            //2、直接调用 系统的，打完电话之后，原来不会返回app中（可以上架）但是现在 也可以返回app
            if ([[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:@"tel://10086"]])
            {
                [[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:@"tel://10086"]];
            }
    }else if (indexPath.row ==2){
        //3.这种出现过上架的问题
            if ([[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:@"telprompt://10086"]])
            {
                [[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:@"telprompt://10086"]];
            }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
