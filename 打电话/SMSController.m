//
//  SMSController.m
//  打电话
//
//  Created by 李攀祥 on 16/7/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SMSController.h"
#import <MessageUI/MessageUI.h>
@interface SMSController ()<MFMessageComposeViewControllerDelegate>
@end
@implementation SMSController
#pragma mark ----MessageDelegate
/**
 *  @param controller 就是弹出的发短信的控制器
 *  @param result  你点击的按钮
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
            break;
        case MessageComposeResultSent:
            NSLog(@"已发送");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");//这个 一般不会有，除非没有信号的地方
            break;
        default:
            break;
    }
    //随便点击完成之后，就会把这个发短信的控制器，收起来。
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark ---- 返回上一页
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark ---- 外部调用  可以直接返回该app
- (IBAction)OutB:(id)sender {
    //这个是直接弹到系统的信息中 发送信息
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13720329661"]];
}

#pragma mark ---- app内部调用   出现的bug  比较多
#pragma mark ---- 点击按钮发送  发短信
- (IBAction)InB:(id)sender {
    //这个是 在本程序内调用 发短信
        [self showMessageView:@[@"13720329661"]  body:@"woca"];    
}

#pragma mark ---- 发短信的方法
/**
 *  @param phones 你发信息的  收件人 可以用数组放在一起
 *  @param body   信息的内容
 */
- (void)showMessageView:(NSArray *)phones  body:(NSString *)body
{
    
    //如果这个设备能发送信息的话
    if([MFMessageComposeViewController canSendText]) {
        //就初始化这个发短信的控制器
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        // 收信息号码的数组，数组中有一个是单发,多个是群发。
        controller.recipients = phones;
        //这个是取消按钮的颜色
        controller.navigationBar.tintColor = [UIColor blackColor];
        // 短信内容
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
         message:@"该设备不支持短信功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
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
