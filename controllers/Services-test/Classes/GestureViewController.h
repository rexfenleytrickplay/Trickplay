//
//  GestureViewController.h
//  Services-test
//
//  Created by Rex Fenley on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketManager.h"


@interface GestureViewController : UIViewController {
    SocketManager *socketManager;
    UITextField *serviceName;
}

@property (retain) IBOutlet UITextField *serviceName;

-(void) startService:(NSInteger)port
            hostname:(NSString *)hostName
            thetitle:(NSString *)name;

@end