//
//  RXLogWindowWindowController.m
//  REFx4
//
//  Created by Pim Snel on 10-09-13.
//
//

#import "RXLogWindowController.h"
#import "REFx3AppDelegate.h"

@interface RXLogWindowController ()

@end

@implementation RXLogWindowController


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {

    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)openLogInConsoleApp:(id)sender
{
    [[NSWorkspace sharedWorkspace] openFile:[[NSApp delegate] engineLogFilePath] withApplication:@"Console"];

    //logFilePath = [[NSApp delegate] engineLogFilePath];

    
}


@end
