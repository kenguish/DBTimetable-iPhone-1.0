//
//  AboutViewController.h
//  HK Libraries
//
//  Created by Kenneth Anguish on 7/23/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate, UIScrollViewDelegate> {
	IBOutlet UIScrollView *scrollView;

	UIWebView *webView;
	
	IBOutlet UIButton *fleurButton;
	IBOutlet UIButton *suggestionButton;
	
	IBOutlet UITextField *feedbackButton;
	
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UITextField *feedbackButton;

- (IBAction)openFleur:(id)sender;
- (IBAction)openTaoful:(id)sender;
- (IBAction)openFacebook:(id)sender;

-(IBAction)sendFeedBack:(id)sender;
-(void)displayComposerSheet;

@end
