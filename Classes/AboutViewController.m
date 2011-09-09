//
//  AboutViewController.m
//  DBTimeTable
//
//  Created by Kenneth Anguish on 7/23/09.
//  Copyright 2009 Pulsely, Ltd. All rights reserved.
//

#import "AboutViewController.h"
#import "DBTimetableUrls.h"

@implementation AboutViewController
@synthesize scrollView, webView;
@synthesize feedbackButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake( 0, 45, 320, 365)];
	[self.view addSubview: scrollView];
	
	scrollView.contentSize = CGSizeMake(320, 365);
	
	NSString *helpfilepath = [[NSBundle mainBundle] pathForResource:@"helpContent" ofType:@"html"];
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:helpfilepath];
	
	NSString *htmlString_src = [[NSString alloc] initWithData: 
							[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	
	NSString *htmlString = [NSString stringWithFormat: htmlString_src, APP_VERSION];
	// [htmlString_src release];
	
	NSString *basepath = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:basepath];
	
	// to make html content transparent to its parent view -
	// 1) set the webview's backgroundColor property to [UIColor clearColor]
	// 2) use the content in the html: <body style="background-color: transparent">
	// 3) opaque property set to NO
	//
	
	webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
	webView.opaque = NO;
	webView.backgroundColor = [UIColor clearColor];
	[self.webView loadHTMLString: htmlString baseURL: baseURL];
	
	
	[scrollView addSubview: webView];
	[webView setUserInteractionEnabled: NO];
	
	[htmlString_src release];
	
	// Create buttons
	
	UIButton *btn1 = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
	btn1.frame = CGRectMake(30, 220, 255, 37);
	btn1.bounds = CGRectMake(0, 0, 255.0, 37.0);
	[btn1 setTitle: @"Fleur Hong Kong http://fleur.hk" forState: UIControlStateNormal];
	//[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
	[btn1 addTarget:self action:@selector(openFleur:) forControlEvents:UIControlEventTouchUpInside];
	
	[scrollView addSubview: btn1];
	
	UIButton *btn2 = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
	btn2.frame = CGRectMake(30, 270, 255, 37);
	btn2.bounds = CGRectMake(0, 0, 255.0, 37.0);
	[btn2 setTitle: @"Taoful http://taoful.com" forState: UIControlStateNormal];
	//[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
	[btn2 addTarget:self action:@selector(openTaoful:) forControlEvents:UIControlEventTouchUpInside];
	
	[scrollView addSubview: btn2];

	
	UIButton *btn3 = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
	btn3.frame = CGRectMake(30, 320, 255, 37);
	btn3.bounds = CGRectMake(0, 0, 255.0, 37.0);
	[btn3 setTitle: @"E-mail feedbacks to developers" forState: UIControlStateNormal];
	//[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
	[btn3 addTarget:self action:@selector(sendFeedBack:) forControlEvents:UIControlEventTouchUpInside];
	
	[scrollView addSubview: btn3];
	
	UIButton *btn4 = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
	btn4.frame = CGRectMake(30, 370, 255, 37);
	btn4.bounds = CGRectMake(0, 0, 255.0, 37.0);
	[btn4 setTitle: @"Facebook Fan Page" forState: UIControlStateNormal];
	//[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
	[btn4 addTarget:self action:@selector(openFacebook:) forControlEvents:UIControlEventTouchUpInside];
	
	[scrollView addSubview: btn4];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
    [super dealloc];
}

- (IBAction)openFleur:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://fleur.hk/"]]; 
}

- (IBAction)openTaoful:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://taoful.com/"]]; 
}


- (IBAction)openFacebook:(id)sender {
	NSURL *fanPageURL = [NSURL URLWithString: 
						 [NSString stringWithFormat: @"fb://profile/%@", FACEBOOK_APP_ID ]];
	
	if (![[UIApplication sharedApplication] openURL: fanPageURL]) {
        //fanPageURL failed to open.  Open the website in Safari instead
        NSURL *webURL = [NSURL URLWithString:
						 [NSString stringWithFormat: @"http://touch.facebook.com/#/profile.php?id=%@", FACEBOOK_APP_ID ]];
        [[UIApplication sharedApplication] openURL: webURL];
	}
}

#pragma mark -
#pragma mark Mail Composer

-(IBAction)sendFeedBack:(id)sender
{
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
	}
}

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Suggestion to Discovery Bay Timetable 2.0 for iPhone"];
	
	/*
	UIGraphicsBeginImageContext( webview.bounds.size );
	[webview.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    // NSData *myData = [NSData dataWithContentsOfFile:path];
	NSData *myData = UIImagePNGRepresentation( viewImage );
	
	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"pcam"];
	*/
	
	// Fill out the email body text
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:NO];
	[picker setToRecipients: [NSArray arrayWithObject: @"dbtimetable@fleur.hk"]];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	/*
	statusLabel.hidden = NO;
	switch (result)
	{
		case MFMailComposeResultCancelled:
			statusLabel.text = @"E-mail sending cancelled";
			[self performSelector: @selector(eraseStatus) withObject: nil afterDelay: 2];
			break;
		case MFMailComposeResultSaved:
			statusLabel.text = @"E-mail saved";
			[self performSelector: @selector(eraseStatus) withObject: nil afterDelay: 2];
			break;
		case MFMailComposeResultSent:
			statusLabel.text = @"E-mail sent";
			[self performSelector: @selector(eraseStatus) withObject: nil afterDelay: 2];
			break;
		case MFMailComposeResultFailed:
			statusLabel.text = @"E-mail failed";
			[self performSelector: @selector(eraseStatus) withObject: nil afterDelay: 2];
			break;
		default:
			statusLabel.text = @"E-mail not sent";
			[self performSelector: @selector(eraseStatus) withObject: nil afterDelay: 2];
			break;
	}
	 */
	[self dismissModalViewControllerAnimated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return self.scrollView;
}



@end
