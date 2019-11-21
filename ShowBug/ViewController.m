//
//  ViewController.m
//  ShowBug
//
//  Created by yaojianqiang on 2019/11/20.
//  Copyright © 2019 yjq. All rights reserved.
//

#import "ViewController.h"
#import "ResultController.h"
@interface ViewController()
@property (weak) IBOutlet NSTextField *pathTextField;

@property (unsafe_unretained) IBOutlet NSTextView *errorLogTextView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (IBAction)tryAction:(id)sender {
    NSString* errorLogStr = self.errorLogTextView.string;
    NSString* pathText = self.pathTextField.stringValue;
    __block NSString* appName = nil;
    __block NSString* baseAddress = nil;
    [errorLogStr enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
 
        if([line hasPrefix:@"Binary Image: "]){
            appName = [line stringByReplacingOccurrencesOfString:@"Binary Image: " withString:@""];
        }
        if([line hasPrefix:@"Base Address: "]){
            baseAddress = [line stringByReplacingOccurrencesOfString:@"Base Address: " withString:@""];
        }
    }];
    __block NSMutableArray* errorAddressArr = [NSMutableArray array];
    [errorLogStr enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if([line hasPrefix:appName]){
            NSArray* arr = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            arr=[arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
            if(arr.count > 3){
                if([arr[0] isEqualToString:appName] && [arr[2] isEqualToString:appName]){
                    [errorAddressArr addObject:arr[1]];
//                    *stop=YES;
                }
            }
        }
    }];
    if(appName == nil || baseAddress == nil ||errorAddressArr.count == 0) {
        NSAlert* alert = [[NSAlert alloc] init];
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert setInformativeText:@"信息错误"];
        [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSModalResponse returnCode) {
        }];
        return;
    }
    
    pathText =  [pathText stringByReplacingOccurrencesOfString:@" " withString:@"\\ "];
    pathText =  [pathText stringByReplacingOccurrencesOfString:@"," withString:@"\\,"];
    __block NSMutableString* resultStr = [NSMutableString string];
    [errorAddressArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPipe* pipe = [NSPipe pipe];
        NSTask* task = [[NSTask alloc] init];
        [task setLaunchPath:@"/bin/bash"];
        NSString* cmd = [NSString stringWithFormat:@"xcrun atos -o  %@ -l %@ %@ -arch arm64",pathText,baseAddress,obj];
        [task setArguments:@[@"-c",cmd]];
        [task setStandardOutput:pipe];
        [task setStandardError:pipe];
        NSFileHandle* handle = [pipe fileHandleForReading];
        [task launch];
        NSData* data=[handle readDataToEndOfFile];
        [resultStr appendString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
        
        [handle closeFile];
    }];
    ResultController* resultController = [[NSStoryboard mainStoryboard] instantiateControllerWithIdentifier:@"resultController"];
    NSLog(@"%@",resultStr);
    
    [self presentViewControllerAsModalWindow:resultController];
    resultController.resultLabel.stringValue = resultStr;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
