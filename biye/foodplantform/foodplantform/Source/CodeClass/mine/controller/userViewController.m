//
//  userViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/5/9.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "userViewController.h"
#import "userView.h"
@interface userViewController ()
@property(nonatomic,strong)userView *uv;
@property(nonatomic,assign)BOOL isChange;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@property(nonatomic,assign)BOOL isFullScreen;
@property(nonatomic,strong)BmobObject *upLoadObject;
@end

@implementation userViewController
-(void)loadView
{
    self.uv = [[userView alloc]init];
    self.view = _uv;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"修改信息" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.uv.userName.enabled = NO;
    self.uv.phone.enabled = NO;
    self.uv.gender.enabled = NO;
    self.isChange = YES;
    [self p_loadData];
    
    if ([regAndLogTool shareTools].loginName != nil) {
        self.um = [[userModel alloc]init];
        self.um = [regAndLogTool shareTools].usermodel;
        NSLog(@"name%@",_um.userName);
        NSLog(@"gender%@",_um.gender);
        [self.uv.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.um.head_img]]];
        self.uv.userName.text = _um.userName;
        self.uv.phone.text = _um.mobilePhoneNumber;
        self.uv.gender.text = _um.gender;
    }
    if ([regAndLogTool shareTools].loginName == nil) {
        self.uv.headimg.image = [UIImage imageNamed:@"我的1"];
    }
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.uv.headimg addGestureRecognizer:_tap];
    self.uv.headimg.userInteractionEnabled = YES;
    // Do any additional setup after loading the view.
}

-(void)tapAction
{
    UIActionSheet *sheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
    
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    [self saveImage:image withName:[NSString stringWithFormat:@"%@.png",locationString]];
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *fullPath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",locationString]];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    _isFullScreen = NO;
    
    [self.uv.headimg setImage:savedImage];
    
    self.uv.headimg.tag = 100;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
NSData * UIImageJPEGRepresentation ( UIImage *image, CGFloat compressionQuality);
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *fullPath = [cachesPath stringByAppendingPathComponent:imageName];
    
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.uv.headimg.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.uv.headimg .frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.uv.headimg.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            
            self.uv.headimg.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.uv.headimg.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}


-(void)rightAction
{
    
    self.isChange = !_isChange;
    if (self.isChange == NO) {
        [self.navigationItem.rightBarButtonItem setTitle:@"保存修改"];
        self.uv.userName.enabled = YES;
        //self.uv.phone.enabled = YES;
        self.uv.gender.enabled = YES;
    }
    if (self.isChange == YES) {
    
        self.uv.userName.enabled = NO;
        self.uv.phone.enabled = NO;
        self.uv.gender.enabled = NO;
        self.upLoadObject = [BmobObject objectWithClassName:@"_User"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSDate *date = [NSDate  dateWithTimeIntervalSinceNow:3600*2];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString * strdate = [formatter stringFromDate:date];
        NSString *fileName = [NSString stringWithFormat:@"%@.JPEG",strdate];
        NSData *imageData = UIImageJPEGRepresentation(self.uv.headimg.image, 0.01);
        BmobFile *file = [[BmobFile alloc]initWithFileName:fileName withFileData:imageData];
        [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [_upLoadObject setObject:file forKey:@"head_imgFile"];
                BmobUser *user = [BmobUser getCurrentUser];
                [user setObject:self.uv.userName.text forKey:@"username"];
                [user setObject:self.uv.gender.text forKey:@"gender"];
                [user setObject:file.url forKey:@"head_img"];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[regAndLogTool shareTools] messageShowWith:@"更新成功" cancelStr:@"确定"];
                        
                        [self.uv.headimg sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"head_img"]]];
                        self.uv.userName.text = user.username;
                        self.uv.phone.text = user.mobilePhoneNumber;
                        self.uv.gender.text = [user objectForKey:@"gender"];
                    });
                   
                }];
                
                
            }
        }];
        
        [self.navigationItem.rightBarButtonItem setTitle:@"修改信息"];
    }
}
-(void)p_loadData
{
    //self.uv.headimg.image = [UIImage imageNamed:@"我的1"];
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
