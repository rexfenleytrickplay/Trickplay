//
//  AppBrowserViewController.m
//  TrickplayController_v2
//
//  Created by Rex Fenley on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppBrowserViewController.h"


@implementation AppBrowserViewController

@synthesize theTableView;
@synthesize appsAvailable;
@synthesize currentAppName;

/*
@synthesize appShopButton;
@synthesize showcaseButton;
@synthesize toolBar;
*/
 

- (IBAction)showcaseButtonClick {
}

- (IBAction)appShopButtonClick {
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)setupService:(NSInteger)p
            hostname:(NSString *)h
            thetitle:(NSString *)n {
    
    NSLog(@"Service Setup: %@ host: %@ port: %d", n, h, p);
    
    port = p;
    if (hostName) {
        [hostName release];
    }
    hostName = [h retain];
    
    
    [self createGestureView];
}

- (BOOL)fetchApps {
    if (!port || !hostName) {
        return NO;
    }
    
    // grab json data and put it into an array
    NSString *JSONString = [NSString stringWithFormat:@"http://%@:%d/api/apps", hostName, port];
    //NSLog(@"JSONString = %@", JSONString);
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:JSONString]];
    //NSLog(@"Received JSONData = %@", [NSString stringWithCharacters:[JSONData bytes] length:[JSONData length]]);
    self.appsAvailable = [JSONData yajl_JSON];
    NSLog(@"Received JSON array app data = %@", appsAvailable);
    /*
    for (NSDictionary *element in appsAvailable) {
        NSLog(@"is NSDictionary? %d", [element isKindOfClass:[NSDictionary class]]);

        NSLog(@"element = %@", element);
    }
     */
    
    return YES;
}

- (void)launchApp:(NSDictionary *)appInfo {
    
    NSString *appID = (NSString *)[appInfo objectForKey:@"id"];
    NSString *launchString = [NSString stringWithFormat:@"http://%@:%d/api/launch?id=%@", hostName, port, appID];
    NSLog(@"Launching app via url '%@'", launchString);
    NSURL *launchURL = [NSURL URLWithString:launchString];
    NSData *launchData = [NSData dataWithContentsOfURL:launchURL];
    NSLog(@"launch data = %@", launchData);
    
    self.currentAppName = (NSString *)[appInfo objectForKey:@"name"];
}

- (void)createGestureView {
    gestureViewController = [[GestureViewController alloc] initWithNibName:@"GestureViewController" bundle:nil];
    [gestureViewController setupService:port hostname:hostName thetitle:@"Current Service"];
    if (![gestureViewController startService]) {
        [gestureViewController release];
        gestureViewController = nil;
    }
}

//*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"AppBrowserView Loaded!");
    
    [theTableView setDelegate:self];
    //NSLog(@"theTableView %@", theTableView);
    //NSLog(@"appShopButton %@", appShopButton);
    //NSLog(@"showcaseButton %@", showcaseButton);
    //NSLog(@"toolBar %@", toolBar);
    //NSLog(@"has view %@", self.view);
}
//*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/**
 * Customize the number of rows in the table view.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	/*
	NSUInteger count = [netServiceManager.services count];
	if (count == 0) {
		return 1;
	}
    
	return count;
     */
    if (!appsAvailable || [appsAvailable count] == 0) {
        return 1;
    }
    return [appsAvailable count];
}

/**
 * Customize the appearance of table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableCellIdentifier = @"UITableViewCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier] autorelease];
	}

    if (!appsAvailable || [appsAvailable count] == 0) {
        cell.textLabel.text = @"Apps Will Be Listed Here...";
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (cell.accessoryView) {
            cell.accessoryView = nil;
        }
        return cell;
    }
    
    cell.textLabel.text = (NSString *)[(NSDictionary *)[appsAvailable objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.textColor = [UIColor blackColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

/**
 * Override to support row selection in the table view.
 */
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selected row %@\n", indexPath);
    
    if (!appsAvailable || [appsAvailable count] == 0) {
        return;
    }
    
    
    NSLog(@"gestureViewController %@\n", gestureViewController);
    if (!gestureViewController) {
        [self createGestureView];
    }
    
    if (!currentAppName || [(NSString *)[(NSDictionary *)[appsAvailable objectAtIndex:indexPath.row] objectForKey:@"name"] compare:currentAppName] !=  NSOrderedSame) {
        [gestureViewController clean];
        [self launchApp:(NSDictionary *)[appsAvailable objectAtIndex:indexPath.row]];
    }
    [self.navigationController pushViewController:gestureViewController animated:YES];    
    
	NSIndexPath *indexPath2 = [tableView indexPathForSelectedRow];
	if (indexPath2 != nil)
	{
		[tableView deselectRowAtIndexPath:indexPath2 animated:YES];
	}
	
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    NSLog(@"AppBrowserViewController dealloc");
    if (theTableView) {
        [theTableView release];
    }
    if (appsAvailable) {
        [appsAvailable release];
    }
    if (gestureViewController) {
        [gestureViewController release];
    }
    if (currentAppName) {
        [currentAppName release];
    }
    [super dealloc];
}


@end
