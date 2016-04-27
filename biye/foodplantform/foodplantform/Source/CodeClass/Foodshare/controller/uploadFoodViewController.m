//
//  uploadFoodViewController.m
//  foodplantform
//
//  Created by 马文豪 on 16/4/24.
//  Copyright © 2016年 马文豪. All rights reserved.
//

#import "uploadFoodViewController.h"
#import "loadupFoodView.h"
@interface uploadFoodViewController ()
@property(nonatomic,strong)loadupFoodView *lv;
@property(nonatomic,assign)BOOL isFullScreen;
@property(nonatomic,assign)BOOL isupload;
@end

@implementation uploadFoodViewController

-(void)loadView
{
    self.lv = [[loadupFoodView alloc]init];
    self.view = _lv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lv.imgBtn addTarget:self action:@selector(imgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.lv.chooseRec addTarget:self action:@selector(chooseRecAction) forControlEvents:UIControlEventTouchUpInside];
    [self.lv.chooseSty addTarget:self action:@selector(chooseStyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.lv.upBtn addTarget:self action:@selector(upBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

#pragma ====长传按钮事件=====
-(void)upBtnAction
{
    if ([self.lv.foodName.text isEqualToString:@""] || [self.lv.foodDes.text isEqualToString:@""] || [self.lv.address.text isEqualToString:@""] || [self.lv.rec.text isEqualToString:@""] || [self.lv.sty.text isEqualToString:@""] || self.lv.picture.image == nil) {
        UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [message show];
    }
}



#pragma ====选择照片====
// 选取照片
-(void)imgBtnAction
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
    
    if (actionSheet.tag == 256) {
        if (buttonIndex == 0) {
            return;
        }
        if (buttonIndex == 1) {
            self.lv.rec.text = @"接受预订";
        }
        else
        {
            self.lv.rec.text = @"不接受预订";
        }
    }
    
    if (actionSheet.tag == 257) {
        if (buttonIndex == 0) {
            return;
        }
        if (buttonIndex == 1) {
            self.lv.sty.text = @"堂食";
        }
        else
        {
            self.lv.sty.text = @"外卖";
        }
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
    
    [self.lv.picture setImage:savedImage];
    
    self.lv.picture.tag = 100;
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
    
    CGPoint imagePoint = self.lv.picture.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.lv.picture .frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.lv.picture.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            
            self.lv.picture.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.lv.picture.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}

#pragma ====选择是否接受订单====
-(void)chooseRecAction
{
    UIActionSheet *sheet;
    
   
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"接受预订",@"不接受预订", nil];
        
   
    
    sheet.tag = 256;
    
    [sheet showInView:self.view];

}



#pragma ====选择类型====
-(void)chooseStyAction
{
    UIActionSheet *sheet;
    
    
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"堂食",@"外卖", nil];
    
    
    
    sheet.tag = 257;
    
    [sheet showInView:self.view];
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
