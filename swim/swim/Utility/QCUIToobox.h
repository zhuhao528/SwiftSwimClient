//
//  QCUIToobox.h
//  QingClass
//
//  Created by 0dayZh on 2016/11/15.
//  Copyright © 2016年 qingclass. All rights reserved.
//

#ifndef QCUIToobox_h
#define QCUIToobox_h

/// 通过 storyboard name 直接获得对应 storyboard
#define QCStoryboard(sb) [UIStoryboard storyboardWithName:sb bundle:nil]

/// 获取 storyboard 的初始 view controller
#define QCInitialViewController(sb) [QCStoryboard(sb) instantiateInitialViewController]

/// 通过 vc 的 StoryboardID 和对应 storyboard name 获得 vc 的事例
#define QCViewController(sb, vc)    [QCStoryboard(sb) instantiateViewControllerWithIdentifier:vc]

/// 从 nib 中加载 view
#define QCView(viewNibName) [[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]

#endif /* QCUIToobox_h */
