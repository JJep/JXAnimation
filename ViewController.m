//
//  ViewController.m
//  JXAnimation
//
//  Created by Jep Xia on 2018/4/11.
//  Copyright © 2018年 Jep Xia. All rights reserved.
//

#import "ViewController.h"

#define rgb(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0] // 用10进制表示颜色，例如（255,255,255）黑色

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController {
    int _tickets ;
    NSLock *_lock;
    UIView *testView;
    UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    [cell setBackgroundColor:[UIColor cyanColor]];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
//    [self animateView];
}

- (void)animateView {
    
    [UIView animateWithDuration:1.0
                          delay:2
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self->testView.transform = CGAffineTransformMakeTranslation(0, 0);
                     } completion:nil];
    
    
}

- (void)animateTabl {
    
//    NSArray *cells = tableView.visibleCells;
//
//    CGFloat tableHeight = tableView.bounds.size.height;
//
//    [cells enumerateObjectsUsingBlock:^(UITableViewCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.transform = CGAffineTransformMakeTranslation(0, tableHeight);
//        [UIView animateWithDuration:1.0
//                              delay:0.05* (double)idx
//             usingSpringWithDamping:0.8
//              initialSpringVelocity:0
//                            options:UIViewAnimationOptionRepeat
//                         animations:^{
//                             obj.transform = CGAffineTransformMakeTranslation(0, 0);
//                         }
//                         completion:^(BOOL finished) {
//
//                         }];
//    }];
}

- (void)initTicketSale {
    _tickets = 50;
    _lock = [[NSLock alloc] init];
    
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    
    [queue1 addOperationWithBlock:^{
        [self saleTickets];
    }];
    
    [queue2 addOperationWithBlock:^{
        [self saleTickets];
    }];
}

- (void)saleTickets {
    while (_tickets > 0) {
        [_lock lock];
        _tickets --;
        NSLog(@"还剩下%d票--%@",_tickets,[NSThread currentThread]);
        [_lock unlock];
    }
    NSLog(@"票已售完");
}


- (void)userBlockOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i =0; i< 2; i++) {
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"1...%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i =0; i< 2; i++) {
//            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"2...%@",[NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i =0; i< 2; i++) {
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"3...%@",[NSThread currentThread]);
        }
    }];

    [op addExecutionBlock:^{
        for (int i =0; i< 2; i++) {
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"4...%@",[NSThread currentThread]);
        }
    }];
//
//    [op addExecutionBlock:^{
//        for (int i =0; i< 2; i++) {
//            [NSThread sleepForTimeInterval:2.0];
//            NSLog(@"5...%@",[NSThread currentThread]);
//        }
//    }];
//
//    [op addExecutionBlock:^{
//        for (int i =0; i< 2; i++) {
//            [NSThread sleepForTimeInterval:2.0];
//            NSLog(@"6...%@",[NSThread currentThread]);
//        }
//    }];
//
//    [op addExecutionBlock:^{
//        for (int i =0; i< 2; i++) {
//            [NSThread sleepForTimeInterval:2.0];
//            NSLog(@"7...%@",[NSThread currentThread]);
//        }
//    }];
//
//    [op addExecutionBlock:^{
//        for (int i =0; i< 2; i++) {
//            [NSThread sleepForTimeInterval:2.0];
//            NSLog(@"8...%@",[NSThread currentThread]);
//        }
//    }];
//
//    [op addExecutionBlock:^{
//        for (int i =0; i< 2; i++) {
//            [NSThread sleepForTimeInterval:2.0];
//            NSLog(@"9...%@",[NSThread currentThread]);
//        }
//    }];
    [op start];
}

- (void)useInvocationOperation {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:NULL];
    
    [op start];
}

- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"%d...%@",i,[NSThread currentThread]);
    }
}

static dispatch_queue_t url_session_manager_creation_queue() {
    
    static dispatch_queue_t af_url_session_manager_creation_queue;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        af_url_session_manager_creation_queue = dispatch_queue_create("com.alamofire.networking.session.manager.creation", DISPATCH_QUEUE_SERIAL);

    });
    
    return af_url_session_manager_creation_queue;
    
}



- (void)doBackgroundWork {
//    for (int i = 0; i < 10; i++) {
//        [self delayMethod];
//    }
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0];
        [self performSelectorOnMainThread:@selector(workDone) withObject:nil waitUntilDone:NO];
}

- (void)delayMethod {
    NSLog(@"here we will do some delay work");
}

- (void)workDone {
    NSLog(@"here my background work is done");
}

- (void)oprationQueue {
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"here op will do something, the thread is %@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"here op will do some another thing, the thread is %@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"here op will break down, the thread is %@", [NSThread currentThread]);
    }];
    
    //    [op start];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"now we are in global queue, the thread is %@",[NSThread currentThread]);
    });
}

- (void)startLayer {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(20, 20, 100, 100);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.position = CGPointMake(100, 100);
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.toValue = @1.5;
    animation.beginTime = CACurrentMediaTime() + 5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:nil];
    [self.view.layer addSublayer:layer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
