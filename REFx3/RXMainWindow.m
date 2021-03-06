//
//  RXMainWindow.m
//  REFx
//
//  Created by W.A. Snel on 14-10-11.
//  Copyright 2011 Lingewoud b.v. All rights reserved.
//
#import "REFx3AppDelegate.h"
#import "RXMainWindow.h"
#import "RXREFxIntance.h"
#import "RXJobPicker.h"
#import "RXRailsController.h"




@implementation RXMainWindow

@synthesize startStopButtonCommunicationServer;
@synthesize startStopButtonScheduler;
@synthesize jobMgrView;
@synthesize theWindow;
@synthesize lastJobid;

- (id) initWithWindowNibName:(NSString *)windowNibName
{
    self = [super initWithWindowNibName:windowNibName];
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [theWindow setDelegate:self];

    [startStopButtonScheduler setState:0];   
    [startStopButtonCommunicationServer setState:0];
    
    [self instanciateLogController];
    

    [self.Appversion setStringValue:[NSString stringWithFormat:@"v%@ (%@)",
                                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
}


- (void)instanciateLogController {

    NSString * rootdirectory = [[[NSApp delegate] refxInstance ] railRootDir ];
    NSLog(@"rootdir: %@",rootdirectory);
}


- (IBAction)insertJob:(id)sender
{
    NSString * engine = [_insJobEngine stringValue];
    NSString * body = [_insJobBody stringValue];
    [_insJobPanel orderOut:sender];

    long newid = [[[[NSApp delegate] refxInstance] jobPicker] insertTestJobwithEngine:engine body:body];
    NSLog(@"new id: %li, %@ %@",newid,engine,body);
}

- (void)startStopActionScheduler:(id)sender
{
    if([startStopButtonScheduler state]==1)
    {
        [[[[NSApp delegate] refxInstance] jobPicker] startREFxLoop];
    }
    else
    {
        [[[[NSApp delegate] refxInstance] jobPicker] stopREFxLoop];        
    }
}

// REMOVE WHEN RAILS IS GONE
- (IBAction)flushRailsLog:(id)sender
{
    [[NSApp delegate] flushRailsLogs];
}

- (IBAction)flushEngineLog:(id)sender
{
    [[NSApp delegate] flushEngineLogs];
}

- (IBAction)flushJobs:(id)sender
{
    [[[[NSApp delegate] refxInstance] jobPicker] flushAllJobs];
}

- (IBAction)reinstallDatabase:(id)sender
{
    [[[[NSApp delegate] refxInstance] jobPicker] stopREFxLoop];
    [[[[NSApp delegate] refxInstance ] railsController] stopComServer];
    
    [[NSApp delegate] reinstallDatabase];
}

- (IBAction)openLogWindow:(id)sender
{
    [[NSApp delegate] showLogWindow:sender];
}

- (IBAction)openWebInterface:(id)sender
{
    NSString * webUrl = [NSString stringWithFormat:@"http://localhost:%li", [[NSUserDefaults standardUserDefaults]  integerForKey:@"listenPort"]];
    NSURL * myURL = [NSURL URLWithString: webUrl];
    [[NSWorkspace sharedWorkspace] openURL:myURL];
}
- (IBAction)openEngineFolder:(id)sender
{
    NSString *fullPathString = [[[NSApp delegate] sharedEngineManager] engineDirectoryPath];
    
    NSLog(@"open bundle in filemanager: %@", fullPathString);
    [[NSWorkspace sharedWorkspace] selectFile:fullPathString inFileViewerRootedAtPath:fullPathString];
}

- (IBAction)openTestJobsFolder:(id)sender
{
   [[NSWorkspace sharedWorkspace] selectFile: [[NSApp delegate] testFolderPath] inFileViewerRootedAtPath:[[NSApp delegate] testFolderPath]];
}

- (IBAction)setLastJobId:(id)sender
{
    [[[[NSApp delegate] refxInstance] jobPicker] setJobsLastId:[[self.lastJobid stringValue] integerValue]];
}

- (void)startStopActionCommunicationServer:(id)sender
{   
    if([startStopButtonCommunicationServer state]==1) {
        
        [[[NSApp delegate] refxInstance ] startComServer:[[NSUserDefaults standardUserDefaults] stringForKey:@"listenPort"]];        
    }
    else
    {
        [[[[NSApp delegate] refxInstance ] railsController] stopComServer];        
    }
}




@end
