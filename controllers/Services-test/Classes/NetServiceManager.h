//
//  NetServiceManager.h
//  Services-test
//
//  Created by Rex Fenley on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetServiceManager : NSObject <NSNetServiceBrowserDelegate,
NSNetServiceDelegate> {
    id client;
    UITableView *tableView;
    
    NSNetServiceBrowser *netServiceBrowser;
    NSNetService *currentService;
    NSMutableArray *services;
}

- (id)init:(UITableView *)aTableView client:(id)client;

- (void)handleError:(NSNumber *)error;

@property (retain) UITableView *tableView;

@property (retain) NSNetService *currentService;
@property (retain) NSMutableArray *services;

@end