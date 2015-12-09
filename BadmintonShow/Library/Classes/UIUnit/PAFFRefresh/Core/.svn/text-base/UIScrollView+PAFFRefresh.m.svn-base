//
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//

#import "UIScrollView+PAFFRefresh.h"
#import "PAFFRefreshHeader.h"
#import "PAFFRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (PAFFRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
  method_exchangeImplementations(class_getInstanceMethod(self, method1),
                                 class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
  method_exchangeImplementations(class_getClassMethod(self, method1),
                                 class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (PAFFRefresh)

#pragma mark - header
static const char PAFFRefreshHeaderKey = '\0';
- (void)setPaffHeader:(PAFFRefreshHeader *)paffHeader {
  if (paffHeader != self.paffHeader) {
    // 删除旧的，添加新的
    [self.paffHeader removeFromSuperview];
    [self addSubview:paffHeader];

    // 存储新的
    [self willChangeValueForKey:@"paffHeader"]; // KVO
    objc_setAssociatedObject(self, &PAFFRefreshHeaderKey, paffHeader,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"paffHeader"]; // KVO
  }
}

- (PAFFRefreshHeader *)paffHeader {
  return objc_getAssociatedObject(self, &PAFFRefreshHeaderKey);
}

#pragma mark - footer
static const char PAFFRefreshFooterKey = '\0';
- (void)setPaffFooter:(PAFFRefreshFooter *)footer {
  if (footer != self.paffFooter) {
    // 删除旧的，添加新的
    [self.paffFooter removeFromSuperview];
    [self addSubview:footer];

    // 存储新的
    [self willChangeValueForKey:@"paffFooter"]; // KVO
    objc_setAssociatedObject(self, &PAFFRefreshFooterKey, footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"paffFooter"]; // KVO
  }
}

- (PAFFRefreshFooter *)paffFooter {
  return objc_getAssociatedObject(self, &PAFFRefreshFooterKey);
}

#pragma mark - other
- (NSInteger)totalDataCount {
  NSInteger totalCount = 0;
  if ([self isKindOfClass:[UITableView class]]) {
    UITableView *tableView = (UITableView *)self;

    for (NSInteger section = 0; section < tableView.numberOfSections;
         section++) {
      totalCount += [tableView numberOfRowsInSection:section];
    }
  } else if ([self isKindOfClass:[UICollectionView class]]) {
    UICollectionView *collectionView = (UICollectionView *)self;

    for (NSInteger section = 0; section < collectionView.numberOfSections;
         section++) {
      totalCount += [collectionView numberOfItemsInSection:section];
    }
  }
  return totalCount;
}

static const char PAFFRefreshReloadDataBlockKey = '\0';
- (void)setReloadDataBlock:(void (^)(NSInteger))reloadDataBlock {
  [self willChangeValueForKey:@"reloadDataBlock"]; // KVO
  objc_setAssociatedObject(self, &PAFFRefreshReloadDataBlockKey,
                           reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
  [self didChangeValueForKey:@"reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))reloadDataBlock {
  return objc_getAssociatedObject(self, &PAFFRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock {
  void (^reloadDataBlock)(NSInteger) = self.reloadDataBlock;
  !reloadDataBlock ?: reloadDataBlock(self.totalDataCount);
}
@end

@implementation UITableView (PAFFRefresh)

+ (void)load {
  [self exchangeInstanceMethod1:@selector(reloadData)
                        method2:@selector(mj_reloadData)];
  [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:
                                                withRowAnimation:)
                        method2:@selector(mj_reloadRowsAtIndexPaths:
                                                   withRowAnimation:)];
  [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:
                                                withRowAnimation:)
                        method2:@selector(mj_deleteRowsAtIndexPaths:
                                                   withRowAnimation:)];
  [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:
                                                withRowAnimation:)
                        method2:@selector(mj_insertRowsAtIndexPaths:
                                                   withRowAnimation:)];
  [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:)
                        method2:@selector(mj_reloadSections:withRowAnimation:)];
  [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:)
                        method2:@selector(mj_deleteSections:withRowAnimation:)];
  [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:)
                        method2:@selector(mj_insertSections:withRowAnimation:)];
}

- (void)mj_reloadData {
  [self mj_reloadData];

  [self executeReloadDataBlock];
}

- (void)mj_insertRowsAtIndexPaths:(NSArray *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation {
  [self mj_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];

  [self executeReloadDataBlock];
}

- (void)mj_deleteRowsAtIndexPaths:(NSArray *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation {
  [self mj_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];

  [self executeReloadDataBlock];
}

- (void)mj_reloadRowsAtIndexPaths:(NSArray *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation {
  [self mj_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];

  [self executeReloadDataBlock];
}

- (void)mj_insertSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation {
  [self mj_insertSections:sections withRowAnimation:animation];

  [self executeReloadDataBlock];
}

- (void)mj_deleteSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation {
  [self mj_deleteSections:sections withRowAnimation:animation];

  [self executeReloadDataBlock];
}

- (void)mj_reloadSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation {
  [self mj_reloadSections:sections withRowAnimation:animation];

  [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (PAFFRefresh)

+ (void)load {
  [self exchangeInstanceMethod1:@selector(reloadData)
                        method2:@selector(mj_reloadData)];
  [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:)
                        method2:@selector(mj_reloadItemsAtIndexPaths:)];
  [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:)
                        method2:@selector(mj_insertItemsAtIndexPaths:)];
  [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:)
                        method2:@selector(mj_deleteItemsAtIndexPaths:)];
  [self exchangeInstanceMethod1:@selector(reloadSections:)
                        method2:@selector(mj_reloadSections:)];
  [self exchangeInstanceMethod1:@selector(insertSections:)
                        method2:@selector(mj_insertSections:)];
  [self exchangeInstanceMethod1:@selector(deleteSections:)
                        method2:@selector(mj_deleteSections:)];
}

- (void)mj_reloadData {
  [self mj_reloadData];

  [self executeReloadDataBlock];
}

- (void)mj_insertSections:(NSIndexSet *)sections {
  [self mj_insertSections:sections];

  [self executeReloadDataBlock];
}

- (void)mj_deleteSections:(NSIndexSet *)sections {
  [self mj_deleteSections:sections];

  [self executeReloadDataBlock];
}

- (void)mj_reloadSections:(NSIndexSet *)sections {
  [self mj_reloadSections:sections];

  [self executeReloadDataBlock];
}

- (void)mj_insertItemsAtIndexPaths:(NSArray *)indexPaths {
  [self mj_insertItemsAtIndexPaths:indexPaths];

  [self executeReloadDataBlock];
}

- (void)mj_deleteItemsAtIndexPaths:(NSArray *)indexPaths {
  [self mj_deleteItemsAtIndexPaths:indexPaths];

  [self executeReloadDataBlock];
}

- (void)mj_reloadItemsAtIndexPaths:(NSArray *)indexPaths {
  [self mj_reloadItemsAtIndexPaths:indexPaths];

  [self executeReloadDataBlock];
}
@end
