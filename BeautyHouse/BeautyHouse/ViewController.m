//
//  ViewController.m
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Block.h"
#import "Masonry.h"
#import <AVOSCloud/AVOSCloud.h>

#import "ProductViewController.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIImageView *userHeadImageView;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UIImagePickerController*picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //向 LeanCloud 云端保存一条数据
//    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
//    [testObject setObject:@"bar" forKey:@"foo"];
//    [testObject save];
    
    [self.view addSubview:self.userHeadImageView];
    [self.userHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.height.width.mas_equalTo(60);
    }];
    
    [self.view addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(78, 39));
    }];

    [self login];
    
//    [self postProduct];
    WS(ws)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [ws showProduct];
        ProductViewController *vc = [[ProductViewController alloc]init];
        [ws presentViewController:vc animated:YES completion:nil];
    });
    
}

- (void)signUp{
    NSString *username = @"name123";//self.usernameTextField.text;
    NSString *password = @"password123";//self.passwordTextField.text;
    NSString *email = @"email123@gmail.com";//self.emailTextField.text;
    if (username && password && email) {
        // LeanCloud - 注册
        // https://leancloud.cn/docs/leanstorage_guide-objc.html#用户名和密码注册
        AVUser *user = [AVUser user];
        user.username = username;
        user.password = password;
        user.email = email;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"注册成功");
            } else {
                NSLog(@"注册失败 %@", error);
            }
        }];
    }
}

- (void)login{
    NSString *username = @"name123";//self.usernameTextField.text;
    NSString *password = @"password123";//self.passwordTextField.text;
    if (username && password) {
        // LeanCloud - 登录
        // https://leancloud.cn/docs/leanstorage_guide-objc.html#登录
        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
            if (error) {
                NSLog(@"登录失败 %@", error);
            } else {
               NSLog(@"登录成功");
            }
        }];
    }
}

- (void)coustomUserParam{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    NSString *currentEmail = [AVUser currentUser].email; // 当前用户的邮箱
    // 请注意，以下代码无法获取密码
    NSString *currentPassword = [AVUser currentUser].password;//  currentPassword 是 nil
    
    //设置属性
    [[AVUser currentUser] setObject:[NSNumber numberWithInt:25] forKey:@"age"];
    [[AVUser currentUser] saveInBackground];
}

//匿名用户
- (void)noNameUser{
    [AVAnonymousUtils logInWithBlock:^(AVUser *user, NSError *error) {
        if (user && !error) {
            // 登录成功
        } else {
            // 登录失败
        }
    }];
}

- (void)postProduct{
    /**
     属性名              类型                 含义
     title              String              商品标题
     description        String              商品描述
     price              Number              商品价格
     owner              Pointer             所有者
     image              File                封面图片
     
     +++++++++++++++++++++++++++++++++++++++++++++++
     
     这里还有两个属性比较特殊：
     +
     所有者
     封面图片
     Pointer 类型，本质上是指向另外一张表的指针。在这个案例里，owner 字段，就是 Product 表里，用来指向 _User 表里一名用户的指针。
     +
     File 类型，对应着 AVFile。 AVFile 是用来描述一个文件的特殊对象，与之相关的数据都保存在 _File 数据表中。
     +
     依次输入商品标题、商品描述和商品价格，并从相册挑选一张封面图片后，点击发布，成功后，在你的控制台里会新增一张名为 Product 的表，同时表里会有一条新数据。具体代码如下：
     */
    NSString *title = @"屈臣氏1111";//self.titleTextField.text;
    NSNumber *price = [NSNumber numberWithInt:38];//[NSNumber numberWithInt:[self.priceTextField.text intValue]];
    NSString *description = @"deluxe锦韧亲肤无刺激 压花工艺";//self.descriptionTextView.text;
    
    // 保存商品信息
    // LeanCloud - 构建图片
    // https://leancloud.cn/docs/leanstorage_guide-objc.html#从数据流构建文件
    NSData *data = UIImagePNGRepresentation(self.userHeadImageView.image);
    AVFile *file = [AVFile fileWithData:data];
    // LeanCloud - 获取当前用户
    // https://leancloud.cn/docs/leanstorage_guide-objc.html#当前用户
    AVUser *currentUser = [AVUser currentUser];
    
    // LeanCloud - 保存对象
    // https://leancloud.cn/docs/leanstorage_guide-objc.html#对象
    AVObject *product = [AVObject objectWithClassName:@"Product"];
    [product setObject:title forKey:@"title"];
    [product setObject:price forKey:@"price"];
    
    // owner 字段为 Pointer 类型，指向 _User 表
    [product setObject:currentUser forKey:@"owner"];
    // image 字段为 File 类型
    [product setObject:file forKey:@"image"];
    [product setObject:description forKey:@"description"];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@"今日必做"];
    [array addObject:@"老婆吩咐"];
    [array addObject:@"十分重要"];
    [product setObject:array forKey:@"Tag"];
    
//    AVRelation *relation = [product relationForKey:@"tags"];// 新建一个 AVRelation
//    [relation addObject:tag1];
//    [relation addObject:tag2];
//    [relation addObject:tag3];
//
    
    [product saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"保存新物品成功");
        } else {
            NSLog(@"保存新物品出错 %@", error);
        }
    }];
}

- (void)showProduct{
    // LeanCloud - 查询 - 获取商品列表
    // https://leancloud.cn/docs/leanstorage_guide-objc.html#查询
    AVQuery *query = [AVQuery queryWithClassName:@"Product"];
    [query orderByDescending:@"createdAt"];
    // owner 为 Pointer，指向 _User 表
    [query includeKey:@"owner"];
    // image 为 File
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"物品展示区");
        }
    }];
}

- (void)logOut{
    // LeanCloud - 退出登录
    // https://leancloud.cn/docs/leanstorage_guide-objc.html#登出
    [AVUser logOut];
}

- (void)Todo{
    //创建了一个 Todo 类型的对象，并将它保存到云端：
    AVObject *todo = [AVObject objectWithClassName:@"Todo"];
    [todo setObject:@"工程师周会" forKey:@"title"];
    [todo setObject:@"每周工程师会议，周一下午2点" forKey:@"content"];
    [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 存储成功
        } else {
            // 失败的话，请检查网络环境以及 SDK 配置是否正确
        }
    }];
    
    /*
     AVObject *todo = [AVObject objectWithClassName:@"Todo"];
     [todo setObject:@"工程师周会" forKey:@"title"];
     [todo setObject:@"每周工程师会议，周一下午2点" forKey:@"content"];
     [todo setObject:@"会议室" forKey:@"location"];// 只要添加这一行代码，云端就会自动添加这个字段
     [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
     if (succeeded) {
     // 存储成功
     } else {
     // 失败的话，请检查网络环境以及 SDK 配置是否正确
     }
     }];
     */
}

//获取对象
- (void)getObjectWithId:(NSString *)objectId{
    AVQuery *query = [AVQuery queryWithClassName:@"Todo"];
    [query getObjectInBackgroundWithId:objectId block:^(AVObject *object, NSError *error) {
        // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
    }];
    
    // 第一个参数是 className，第二个参数是 objectId
    AVObject *todo =[AVObject objectWithClassName:@"Todo" objectId:@"558e20cbe4b060308e3eb36c"];
    [todo fetchInBackgroundWithBlock:^(AVObject *avObject, NSError *error) {
        NSString *title = avObject[@"title"];// 读取 title
        NSString *content = avObject[@"content"]; // 读取 content
    }];
}

//获取 objectId
- (void)getObjectId{
    //每一次对象存储成功之后，云端都会返回 objectId，它是一个全局唯一的属性。
    AVObject *todo = [AVObject objectWithClassName:@"Todo"];
    [todo setObject:@"工程师周会" forKey:@"title"];
    [todo setObject:@"每周工程师会议，周一下午2点" forKey:@"content"];
    [todo setObject:@"会议室" forKey:@"location"];// 只要添加这一行代码，云端就会自动添加这个字段
    [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 存储成功
            NSLog(@"%@",todo.objectId);// 保存成功之后，objectId 会自动从云端加载到本地
        } else {
            // 失败的话，请检查网络环境以及 SDK 配置是否正确
        }
    }];
}

//访问对象的属性
- (void)readParam{
     //访问Todo 的属性的方式为：
    AVQuery *query = [AVQuery queryWithClassName:@"Todo"];
    [query getObjectInBackgroundWithId:@"558e20cbe4b060308e3eb36c" block:^(AVObject *object, NSError *error) {
        // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
        int priority = [[object objectForKey:@"priority"] intValue];
        NSString *location = [object objectForKey:@"location"];
        NSString *title = object[@"title"];
        NSString *content = object[@"content"];
        
        // 获取三个特殊属性
        NSString *objectId = object.objectId;
        NSDate *updatedAt = object.updatedAt;
        NSDate *createdAt = object.createdAt;
    }];
    
    /**
     请注意以上代码中访问三个特殊属性 objectId、createdAt、updatedAt 的方式。
     如果访问了并不存在的属性，SDK 并不会抛出异常，而是会返回空值。
     */
}

//同步对象
- (void)reloadObject{
    //多终端共享一个数据时，为了确保当前客户端拿到的对象数据是最新的，可以调用刷新接口来确保本地数据与云端的同步：
    
    // 使用已知 objectId 构建一个 AVObject
    AVObject *anotherTodo = [AVObject objectWithClassName:@"Todo" objectId:@"5656e37660b2febec4b35ed7"];
    // 然后调用刷新的方法，将数据从云端拉到本地
    [anotherTodo fetchInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        // 此处调用 fetchInBackgroundWithBlock 和 refreshInBackgroundWithBlock 效果一样。
    }];
}

//同步指定属性
- (void)reloadObjectOfParam{
    //目前 Todo 这个类已有四个自定义属性：priority、content、location 和 title。为了节省流量，现在只想刷新 priority 和 location 可以使用如下方式：
    AVObject *theTodo = [AVObject objectWithClassName:@"Todo" objectId:@"564d7031e4b057f4f3006ad1"];
    NSArray *keys = [NSArray arrayWithObjects:@"priority", @"location",nil];// 指定刷新的 key 数组
    [theTodo fetchInBackgroundWithKeys:keys block:^(AVObject *object, NSError *error) {
        // theTodo 的 priority 和 location 属性的值就是与云端一致的
        NSString *priority = [object objectForKey:@"priority"];
        NSString *location = object[@"location"];
    }];
}

//更新对象
- (void)updataObject{
    // 第一个参数是 className，第二个参数是 objectId
    AVObject *todo =[AVObject objectWithClassName:@"Todo" objectId:@"558e20cbe4b060308e3eb36c"];
    // 修改属性
    [todo setObject:@"每周工程师会议，本周改为周三下午3点半。" forKey:@"content"];
    // 保存到云端
    [todo saveInBackground];
}

- (void)updataWithOption{
    /**
     通过使用 保存选项 query 可以按照指定条件去更新对象——当条件满足时，执行更新；条件不满足时，不执行更新。
     例如：用户的账务账户表 Account 有一个余额字段 balance，同时有多个请求要修改该字段值，为避免余额出现负值，只有满足 balance >= 当前请求的数值 这个条件才允许修改，否则提示「余额不足，操作失败！」。
     */
    NSInteger amount = -100;
    AVObject *account = [[AVQuery queryWithClassName:@"Account"] getFirstObject];
    
    [account incrementKey:@"balance" byAmount:@(amount)];
    
    AVQuery *query = [[AVQuery alloc] init];
    [query whereKey:@"balance" greaterThanOrEqualTo:@(-amount)];
    
    AVSaveOption *option = [[AVSaveOption alloc] init];
    
    option.query = query;
    option.fetchWhenSave = YES;
    
    [account saveInBackgroundWithOption:option block:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"当前余额为：%@", account[@"balance"]);
        } else if (error.code == 305) {
            NSLog(@"余额不足，操作失败！");
        }
    }];
}

/**
 NSNumber     *boolean    = @(YES);
 NSNumber     *number     = [NSNumber numberWithInt:2015];
 NSString     *string     = [NSString stringWithFormat:@"%@ 年度音乐排行", number];
 NSDate       *date       = [NSDate date];
 
 NSData       *data       = [@"短篇小说" dataUsingEncoding:NSUTF8StringEncoding];
 NSArray      *array      = [NSArray arrayWithObjects:
 string,
 number,
 nil];
 NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
 number, @"数字",
 string, @"字符串",
 nil];
 
 AVObject     *object     = [AVObject objectWithClassName:@"DataTypes"];
 [object setObject:boolean    forKey:@"testBoolean"];
 [object setObject:number     forKey:@"testInteger"];
 [object setObject:string     forKey:@"testString"];
 [object setObject:date       forKey:@"testDate"];
 [object setObject:data       forKey:@"testData"];
 [object setObject:array      forKey:@"testArray"];
 [object setObject:dictionary forKey:@"testDictionary"];
 [object saveInBackground];
 
 NSDictionary 和 NSArray 支持嵌套，这样在一个 AVObject 中就可以使用它们来储存更多的结构化数据。
 大数据 建议使用 AVFile。
 */


#pragma mark 选择图片

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.userHeadImageView.image = image;
    
    [self postProduct];
}

// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImageView *)userHeadImageView{
    if (!_userHeadImageView) {
        _userHeadImageView = [[UIImageView alloc]init];
    }
    return _userHeadImageView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor =[UIColor blueColor];
        [_addButton setTitle:@"添加" forState:UIControlStateNormal];
  
        WS(ws)
        [_addButton addActionforControlEvents:UIControlEventTouchUpInside Completion:^{
            // 创建UIImagePickerController实例
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            // 设置代理
            imagePickerController.delegate = ws;
            // 是否允许编辑（默认为NO）
            imagePickerController.allowsEditing = YES;
            // 创建一个警告控制器
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            // 设置警告响应事件
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 设置照片来源为相机
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                // 设置进入相机时使用前置或后置摄像头
                imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                // 展示选取照片控制器
                [ws presentViewController:imagePickerController animated:YES completion:^{}];
            }];
            
            
            UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [ws presentViewController:imagePickerController animated:YES completion:^{}];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                // 添加警告按钮
                [alert addAction:cameraAction];
            }
            [alert addAction:photosAction];
            [alert addAction:cancelAction];
            // 展示警告控制器
            [ws presentViewController:alert animated:YES completion:nil];
            
        }];
    }
    return _addButton;
}
@end
