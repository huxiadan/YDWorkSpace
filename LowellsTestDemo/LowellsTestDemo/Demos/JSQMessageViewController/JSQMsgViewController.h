//
//  JSQMsgViewController.h
//  LowellsTestDemo
//
//  Created by lowell on 4/7/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessages.h"
#import "DemoModelData.h"
#import "NSUserDefaults+DemoSettings.h"

@class DemoMessagesViewController;

@protocol JSQDemoViewControllerDelegate <NSObject>

- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc;

@end

@interface JSQMsgViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate>
@property (weak, nonatomic) id<JSQDemoViewControllerDelegate> delegateModal;

@property (strong, nonatomic) DemoModelData *demoData;

- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)closePressed:(UIBarButtonItem *)sender;
@end
