//
//  KCMainViewController.m
//  MapKit Annotation
//
//  Created by Kenshin Cui on 14/3/27.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//  37.785834   -122.406417
//  39.92 116.39

#import "KCMainViewController.h"


@interface KCMainViewController ()<MKMapViewDelegate,UISearchBarDelegate>

{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGUI];
    [self initSearchBar];
//    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
//    float zoomLevel = 0.02;
//    MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel, zoomLevel));
//    [map setRegion:[map regionThatFits:region] animated:YES];
    UIBarButtonItem *rightMapItem = [[UIBarButtonItem alloc] initWithTitle:@"选择当前位置" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemMapBtnAction)];
    self.navigationItem.rightBarButtonItem = rightMapItem;
}
- (void)rightItemMapBtnAction
{
    [self getLoctionWithCLLocationCoordinate2D:_currentCLLocationCoordinate2D];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark 添加地图控件
-(void)initGUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;

    [_mapView addGestureRecognizer:longPressGr];
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;
    
    //添加大头针
    // [self addAnnotation];
}
- (void)longPressToDo:(UIGestureRecognizer*)gestureRecognizer {
    
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];//这里touchPoint是点击的某点在地图控件中的位置
        CLLocationCoordinate2D touchMapCoordinate =
        [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];//这里touchMapCoordinate就是该点的经纬度了
        [self getLoctionWithCLLocationCoordinate2D:touchMapCoordinate];

    }
    
}
- (void)getLoctionWithCLLocationCoordinate2D: (CLLocationCoordinate2D) touchMapCoordinate
{
    //将经纬度转化成位置信息
    CLLocation *location = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    CLGeocoder *rev = [[CLGeocoder alloc] init];
    [rev reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error||placemarks.count==0)
        {
            
        }else
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            // 1.跳出弹出框，提示用户打开步骤。

            NSString *placeStr = firstPlacemark.thoroughfare==nil&&firstPlacemark.subThoroughfare ==nil? firstPlacemark.name:[NSString stringWithFormat:@"%@%@%@%@",firstPlacemark.locality,firstPlacemark.subLocality,firstPlacemark.thoroughfare==nil?@"":firstPlacemark.thoroughfare,firstPlacemark.subThoroughfare ==nil?@"":firstPlacemark.subThoroughfare];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你要选择的地址是" message:placeStr preferredStyle:UIAlertControllerStyleAlert];
            NSLog(@"\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n locality:%@\n subLocality:%@\n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",firstPlacemark.country,firstPlacemark.postalCode,firstPlacemark.ISOcountryCode,
                  firstPlacemark.administrativeArea,firstPlacemark.subAdministrativeArea,firstPlacemark.locality,firstPlacemark.subLocality,firstPlacemark.thoroughfare,firstPlacemark.subThoroughfare);\
            NSLog(@"name------%@",firstPlacemark.name);
            /*
             administrativeArea:郑州市
             subAdministrativeArea:中原区
             thoroughfare:华山路
             subThoroughfare:92号
             */
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //确定按钮的点击事件
                if ([_delegate respondsToSelector:@selector(KCMainViewControllerLongProessGetLoaction:WithLongitude:WithLatitude:)]) {
                    [_delegate KCMainViewControllerLongProessGetLoaction:placeStr WithLongitude:touchMapCoordinate.longitude WithLatitude:touchMapCoordinate.latitude];
                    //                        stringWithFormat:@"%@%@%@%@",firstPlacemark.locality==NULL?nil:firstPlacemark.locality,firstPlacemark.subLocality==NULL?nil:firstPlacemark.locality,firstPlacemark.thoroughfare==NULL?nil:firstPlacemark.locality,firstPlacemark.subThoroughfare==NULL?nil:firstPlacemark.locality]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            //显示最前面的地标信息
            NSLog(@"firstPlacemark.name----------%@",firstPlacemark.name);
            //经纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            
            NSLog(@"firstPlacemark.name----------%.2f",latitude);
            
            NSLog(@"firstPlacemark.name----------%.2f",longitude);
            
        }
    }];

}
#pragma mark 添加大头针
-(void)addAnnotation:(CLLocationCoordinate2D)location1
{
   // CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
//    annotation1.title=@"CMJ Studio";
//    annotation1.subtitle=@"Kenshin Cui's Studios";
    annotation1.coordinate=location1;
    annotation1.image=[UIImage imageNamed:@"icon_pin_floating.png"];
    annotation1.icon=[UIImage imageNamed:@"icon_mark1.png"];
//    annotation1.detail=@"CMJ Studio...";
    annotation1.rate=[UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation1];
    
//    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
//    KCAnnotation *annotation2=[[KCAnnotation alloc]init];
//    annotation2.title=@"Kenshin&Kaoru";
//    annotation2.subtitle=@"Kenshin Cui's Home";
//    annotation2.coordinate=location2;
//    annotation2.image=[UIImage imageNamed:@"icon_paopao_waterdrop_streetscape.png"];
//    annotation2.icon=[UIImage imageNamed:@"icon_mark2.png"];
//    annotation2.detail=@"Kenshin Cui...";
//    annotation2.rate=[UIImage imageNamed:@"icon_Movie_Star_rating.png"];
//    [_mapView addAnnotation:annotation2];
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
//    if ([annotation isKindOfClass:[KCAnnotation class]]) {
//        static NSString *key1=@"AnnotationKey1";
//        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
//        //如果缓存池中不存在则新建
//        if (!annotationView) {
//            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
////            annotationView.canShowCallout=true;//允许交互点击
//            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
//            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
//        }
//
//        //修改大头针视图
//        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
//        annotationView.annotation=annotation;
//        //annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
//        
//        return annotationView;
//    }else if([annotation isKindOfClass:[KCCalloutAnnotation class]]){
//        //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
//        KCCalloutAnnotationView *calloutView=[KCCalloutAnnotationView calloutViewWithMapView:mapView];
//        calloutView.annotation=annotation;
//        return calloutView;
//    } else {
//        return nil;
//    }
//}

#pragma mark 选中大头针时触发
//点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    KCAnnotation *annotation=view.annotation;
    if ([view.annotation isKindOfClass:[KCAnnotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
//        [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        KCCalloutAnnotation *annotation1=[[KCCalloutAnnotation alloc]init];
//        annotation1.icon=annotation.icon;
//        annotation1.detail=annotation.detail;
//        annotation1.rate=annotation.rate;
        annotation1.coordinate=view.annotation.coordinate;
        [mapView addAnnotation:annotation1];
        [self getLoctionWithCLLocationCoordinate2D:view.annotation.coordinate];
    }else
    {
        
    }
}

#pragma mark 取消选中时触发
//-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
//    [self removeCustomAnnotation];
//}

#pragma mark 移除所用自定义大头针
//-(void)removeCustomAnnotation{
//    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[KCCalloutAnnotation class]]) {
//            [_mapView removeAnnotation:obj];
//        }
//    }];
//}
#pragma mark 创建一个搜索对象
-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入地理位置";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor cyanColor];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:_searchBar];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
//    NSLog(@"searchBar开始输入");
    
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
//    NSLog(@"我的");
}

/**
 *  搜框中输入关键字的事件响应
 *
 *  @param searchBar  UISearchBar
 *  @param searchText 输入的关键字
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
}

/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"取消吗");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

/**
 *  键盘上搜索事件的响应
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"取");
    [self reverseGeocodeWithStr:searchBar.text];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}
- (void)reverseGeocodeWithStr:(NSString *)locationStr
{
    //1.获得输入的地址
    if (locationStr.length==0) return;
    
    //2.开始地理编码
    //说明：调用下面的方法开始编码，不管编码是成功还是失败都会调用block中的方法
    CLGeocoder *_geocoder=[[CLGeocoder alloc]init];
    [_geocoder geocodeAddressString:locationStr completionHandler:^(NSArray *placemarks, NSError *error) {
        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
        if (error || placemarks.count==0) {
            // 1.跳出弹出框，提示用户打开步骤。
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入的地址有误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                        {}]];
            [self presentViewController:alertController animated:YES completion:nil];
//            NSLog(@"你输入的地址没找到，可能在月球上") ;
        }else   //  编码成功，找到了具体的位置信息
        {
            //打印查看找到的所有的位置信息
            /*
             name:名称
             locality:城市
             country:国家
             postalCode:邮政编码
             */
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
            }
            
            //取出获取的地理信息数组中的第一个显示在界面上
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //详细地址名称
//            NSLog(@"你输入的地址没找到可能在月球上-----%@",firstPlacemark.name) ;
            
//            self.detailAddressLabel.text=firstPlacemark.name;
            //纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            //经度
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(latitude,longitude);
            float zoomLevel = 0.005;
            [self addAnnotation:coords];
            MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel, zoomLevel));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
//             NSLog(@"你经纬度-----%f,%f",latitude,longitude) ;
        }
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
