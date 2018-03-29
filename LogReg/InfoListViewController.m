//
//  InfoListViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/21.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoListViewController.h"

#import "ZSLImagePicker.h"

#import "InfoDetailViewController.h"

#import "InfoModel.h"

@interface InfoListViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;

@property  (nonatomic ,strong)UIImageView *imgView;

@property  (nonatomic ,strong)UITextField *textField;


@end

@implementation InfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"个人资料"];
    
    self.dataSource = [NSMutableArray array];
    
    self.tableArr = @[@"昵称",@"性别",@"个人简介"];
    
    [self creatHeadView];
    
    [self initTableView];
    
    [self loadData];
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)creatHeadView {
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 90)];
    _headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, 80)];
    label.font = FONT15;
    label.textColor = RGB(50, 50, 50);
    label.text = @"头像";
    [_headView addSubview:label];
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 75, 10, 60, 60)];
    
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.height/2;
    [_headView addSubview:_imgView];
    _imgView.image = [UIImage imageNamed:@"avatar"];
    _imgView.userInteractionEnabled = YES;
    
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarUpdate)];
    
    [_imgView addGestureRecognizer:tap];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom , SCREEM_WIDTH, 10)];
    line2.backgroundColor = GRAYCOLOR;
    [_headView addSubview:line2];
    
    
   
}


- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 50)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 44)];
    _tableView.tableFooterView = footView;
    _tableView.backgroundColor = GRAYCOLOR;
    
 
    _tableView.tableHeaderView = self.headView;
}


- (void)submitBtnAction {
    
    [AVUser logOut];  //清除缓存用户对象
    //    AVUser *currentUser = [AVUser currentUser];
    [HUDManager alertText:@"退出成功"];
    [UserManager removeToken];
    [self.navigationController popViewControllerAnimated:YES];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    cell.textLabel.font = FONT15;
    cell.textLabel.text = _tableArr[indexPath.row];
    cell.detailTextLabel.text = _dataSource[indexPath.row];
    
    //    NSString *imgName = _tableArr[indexPath.row];
    //    cell.imageView.image = [UIImage imageNamed:imgName];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if(indexPath.row == 0){
        
        [self nameUpdate];
    }
    else if (indexPath.row == 1){
        
        [self sexUpdate];
    }
    else if (indexPath.row == 2){
        
        InfoDetailViewController *nextVC = [[InfoDetailViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}





- (void)loadData {
    
    
    AVUser *user = [AVUser currentUser];
    
    NSString *name = [user objectForKey:@"name"];
    NSString *sex = [user objectForKey:@"sex"];
    
    AVFile *file = [user objectForKey:@"avatar"];
    
    [_dataSource addObject:name];
    [_dataSource addObject:sex];
    [_dataSource addObject:@""];
    
    [_tableView reloadData];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:file.url]];
}


- (void)avatarUpdate {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"相册");
        
        ZSLImagePicker *picker =  [ZSLImagePicker defaultImagePicker];
        
        picker.completion = ^(NSArray *imgArray){
            
            if(imgArray.count > 0){
                [self setWithImage:imgArray[0]];
            }
        };
        
        [picker pickImageWithVC:self];

    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"拍照");
        ZSLImagePicker *picker =  [ZSLImagePicker defaultImagePicker];
        
        picker.completion = ^(NSArray *imgArray){
            
            if(imgArray.count > 0){
                [self setWithImage:imgArray[0]];
            }
        };
        
        [picker takePhotoWithVC:self];
        
    }]];

    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)setWithImage:(UIImage*)image {
 
    NSLog(@"%@",image);
    
    [InfoModel editImgae:image success:^{
        
        [HUDManager alertText:@"保存成功"];
        
        _imgView.image = image;
    }];

}




- (void)sexUpdate {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"性别修改" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    
    NSString * male = @"男";

    [alertController addAction:[UIAlertAction actionWithTitle:male style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [InfoModel editSex:male success:^{
            
            [HUDManager alertText:@"保存成功"];
            
            [_dataSource replaceObjectAtIndex:1 withObject:male];
            
            [_tableView reloadData];
        }];
        
    }]];
    
    NSString * female = @"女";
    
    [alertController addAction:[UIAlertAction actionWithTitle:female style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [InfoModel editSex:female success:^{
            
            [HUDManager alertText:@"保存成功"];
            
            [_dataSource replaceObjectAtIndex:1 withObject:female];
            
            [_tableView reloadData];
        }];
        
        
        
    }]];
    
    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}




- (void)nameUpdate {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"修改姓名" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        
        [InfoModel editName:_textField.text success:^{
            
            [HUDManager alertText:@"保存成功"];
            
            [_dataSource replaceObjectAtIndex:0 withObject:_textField.text];
            
            [_tableView reloadData];
        }];
        
    }]];
    
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        NSLog(@"添加一个textField就会调用 这个block");
        
        self.textField = textField;
        
    }];
    
    
    
    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
