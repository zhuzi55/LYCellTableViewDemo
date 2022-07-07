//
//  TestTableViewCell.m
//  Demo20210123OC
//
//  Created by liyz on 2022/7/3.
//

#import "TestTableViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHight [UIScreen mainScreen].bounds.size.height
#define kStatusHight [UIApplication sharedApplication].statusBarFrame.size.height

@interface TestTableViewCell()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    [self.contentView addSubview:self.tableView];
    
}

//  tableview相关代理方法
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 20;
 }
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellcell" forIndexPath:indexPath];
     cell.backgroundColor = [UIColor yellowColor];
     cell.textLabel.text = [NSString stringWithFormat:@"嵌套%ld-%ld", self.row, indexPath.row];
     return cell;
 }

 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 50;
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击== %ld-%ld", indexPath.section, indexPath.row);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(cellTableViewDidEnedScroll:)]) {
        [self.delegate cellTableViewDidEnedScroll:scrollView];
    }
}
//
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(cellTableViewScroll:)]) {
        [self.delegate cellTableViewScroll:scrollView];
    }
    
}
// // 懒加载
 -(UITableView *)tableView{
     if (_tableView == nil) {
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHight) style:UITableViewStylePlain];
         _tableView.delegate = self;
         _tableView.dataSource = self;
         [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellcell"];
//         [_tableView registerNib:[UINib nibWithNibName:@"TestXibTableViewCell" bundle:nil] forCellReuseIdentifier:KcellIdentifier];
         _tableView.backgroundColor = [UIColor yellowColor];
         // 凡是nav下的scrollview视图都默认顶部设置64的内边距。
         // 如此设置可以不让自动设置内边距
         if (@available(iOS 11.0, *)) {
             _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
         }
     }
     return _tableView;
 }

@end
