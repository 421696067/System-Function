![If you're doing your best, you won't have any time to worry about failure](http://upload-images.jianshu.io/upload_images/1418424-7a297c597e7aaaa1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
***
###iOS调用系统功能
####一、发短信
**1、程序外调用**

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://13720329661"]];

**2、app内部调用(发完短信后，可以回到app)**
   * 先导入MessageUI.framework 框架
![](http://upload-images.jianshu.io/upload_images/1418424-f4d89e8a1c359a8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](http://upload-images.jianshu.io/upload_images/1418424-2ce8ebc4cc70f92c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
   * 导入`#import <MessageUI/MessageUI.h>`头文件 , 
   * 遵循代理MFMessageComposeViewControllerDelegate，并实现代理方法- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result;


```
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


```


* 发送短信的方法

```
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
```

* 发送短信的方法调用

```
#pragma mark ---- 点击按钮发送  发短信
- (IBAction)InB:(id)sender {
    //这个是 在本程序内调用 发短信
        [self showMessageView:@[@"13720329661"]  body:@"woca"];    
}

```

***
####二、打电话
**1、调用打电话功能（会询问是否拨打电话,电话结束后会返回到应用界面,此种方法是加载了一个UIWebView实现,支持上架App Store）**

```
 //这种 是最好的调用 打电话的方式（打完电话之后,会返回到app）（可以上架）
   UIWebView *webView = [[UIWebView alloc] init];
   [webView loadRequest:[NSURLRequest  requestWithURL:
   [NSURL URLWithString:@"tel://10086"]]];
   [self.view addSubview:webView];
```


**2、调用打电话功能（会直接进行拨打电话,原来电话结束后会留在电话界面）但是现在可以直接回到app**
```
if ([[UIApplication sharedApplication] 
    openURL:[NSURL URLWithString:@"tel://13720329661"]])
{
      [[UIApplication sharedApplication] 
      openURL:[NSURL URLWithString:@"tel://13720329661"]];
}
```


**3、调用打电话功能（会询问是否拨打电话,电话结束后会返回到应用界面,但是有上架App Store有可能会被拒绝） **


```
  if ([[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:@"telprompt://10086"]])
            {
                [[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:@"telprompt://10086"]];
            }


```

***
####三、打开Safir
**调用Safari浏览器功能(在开发中遇到应用内打开网页的需求,建议使用UIWebView打开)**

```
  if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.baidu.com/"]])
 {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
  }
```

***
###iOS调用系统设置
**在iOS开发过程中，有时我们想在应用内实现跳转到系统设置界面，具体常用功能如下，其实这些呢，比较简单  直接一句话搞定，下面以WiFi为例**
》注意：想要实现应用内跳转到系统设置界面功能,需要先在Targets-Info-URL Types-URL Schemes中添加prefs
####跳转到WiFi ,蓝牙,通用，关于等系统设置
```
if ([[UIApplication sharedApplication] 
        canOpenURL:[NSURL URLWithString:@"prefs:root=WIFI"]])
{
      //WIFI
      //Bluetooth  蓝牙
      //General    通用
      //General&path=About  关于
      //LOCATION_SERVICES 定位
      //NOTIFICATIONS_ID  通知
        [[UIApplication sharedApplication] 
        openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
}

```

Demo：[下载地址]()

####相册等功能 ，将在以后持续更新。。。。

####如果喜欢就粉一个吧。。。。。。