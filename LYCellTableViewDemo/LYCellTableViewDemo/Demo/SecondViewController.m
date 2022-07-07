//
//  SecondViewController.m
//  Demo20210123OC
//
//  Created by liyz on 2021/3/25.
//

#import "SecondViewController.h"

#import "TestUITableView.h"
#import "TestTableViewCell.h"


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHight [UIScreen mainScreen].bounds.size.height
#define kStatusHight [UIApplication sharedApplication].statusBarFrame.size.height

static NSInteger kHeaderViewHight = 200;

@interface SecondViewController ()<UITableViewDelegate, UITableViewDataSource,TestTableViewCellDelegate>


@property (nonatomic, strong) TestUITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImgView;

@property (nonatomic, assign) BOOL tableViewCanScroll;
@property (nonatomic, assign) BOOL cellTableViewCanScroll;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.title = @"第二页";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    
        
    
}


-(void)creatUI{
    
    self.tableViewCanScroll = YES;
    self.cellTableViewCanScroll = NO;
        
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerImgView;
                
    
}

#pragma mark - 外部tableview滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"tableview滑动 == %.2f", scrollView.contentOffset.y);
    
    if (self.tableViewCanScroll == NO) {
        self.tableView.contentOffset = CGPointMake(0, kHeaderViewHight);
    }
    
    if (self.tableView.contentOffset.y >= kHeaderViewHight) {
        // 无表头了
        NSLog(@"++++++");
        self.cellTableViewCanScroll = YES;
        self.tableViewCanScroll = NO;
        self.tableView.contentOffset = CGPointMake(0, kHeaderViewHight);
        
    }

}

#pragma mark - cell嵌套列表滑动控制 通过偏移量判断是外部滑动还是内部滑动
-(void)cellTableViewScroll:(UIScrollView *)scrollView{
    NSLog(@"cellTableview滑动 == %.2f", scrollView.contentOffset.y);

    if (self.cellTableViewCanScroll == NO) {
        scrollView.contentOffset  = CGPointZero;
    }
    if (scrollView.contentOffset.y < 0) {
        self.cellTableViewCanScroll = NO;
        self.tableViewCanScroll = YES;
    }
    
}

//** 解决滑到底部无法滑动问题
-(void)cellTableViewDidEnedScroll:(UIScrollView *)scrollView{
    CGFloat maxOffsetY = scrollView.contentSize.height - scrollView.frame.size.height;
    if (scrollView.contentOffset.y >= maxOffsetY) {
        scrollView.contentOffset = CGPointMake(0, maxOffsetY-1);
    }
}


#pragma mark - tableView测试代码
//  tableview相关代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 1;
 }
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     cell.backgroundColor = [UIColor whiteColor];
     cell.row = indexPath.section;
     cell.delegate = self;
     return cell;
 }

 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return kHight;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击== %ld-%ld", indexPath.section, indexPath.row);
}
// // 懒加载
 -(TestUITableView *)tableView{
     if (_tableView == nil) {
         _tableView = [[TestUITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHight) style:UITableViewStylePlain];
         _tableView.delegate = self;
         _tableView.dataSource = self;
         [_tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"cell"];
//         [_tableView registerNib:[UINib nibWithNibName:@"TestXibTableViewCell" bundle:nil] forCellReuseIdentifier:KcellIdentifier];
         _tableView.backgroundColor = [UIColor orangeColor];
         // 凡是nav下的scrollview视图都默认顶部设置64的内边距。
         // 如此设置可以不让自动设置内边距
         if (@available(iOS 11.0, *)) {
             _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
         }
     }
     return _tableView;
 }
-(UIImageView *)headerImgView{
    if (_headerImgView == nil) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeaderViewHight)];
        _headerImgView.backgroundColor = [UIColor yellowColor];
        _headerImgView.image = [UIImage imageNamed:@"hengtu1"];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.layer.masksToBounds = YES;
        _headerImgView.userInteractionEnabled = YES;
    }
    return _headerImgView;
}




@end
