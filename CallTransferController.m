//
//  CallTransferController.m
//  Telephone
//
//  Copyright (c) 2008-2009 Alexei Kuznetsov. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of the copyright holder nor the names of contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "CallTransferController.h"

#import "ActiveTransferCallViewController.h"
#import "EndedTransferCallViewController.h"


@implementation CallTransferController

@synthesize sourceCallController = sourceCallController_;
@synthesize activeAccountViewController = activeAccountViewController_;

- (id)initWithSourceCallController:(CallController *)callController {
  self = [super initWithAccountController:[callController accountController]];
  if (self != nil) {
    [self setSourceCallController:callController];
    AccountController *accountController
      = [[self sourceCallController] accountController];
    activeAccountViewController_
      = [[ActiveAccountViewController alloc]
         initWithAccountController:accountController];
  }
  return self;
}

- (void)dealloc {
  [activeAccountViewController_ release];
  [super dealloc];
}

- (IBAction)closeSheet:(id)sender {
  [NSApp endSheet:[sender window]];
  [[sender window] orderOut:sender];
}


#pragma mark -
#pragma mark CallController methods

- (CallTransferController *)callTransferController {
  return nil;
}

- (IncomingCallViewController *)incomingCallViewController {
  return nil;
}

// Substitutes ActiveTransferCallViewController.
- (ActiveCallViewController *)activeCallViewController {
  if (activeCallViewController_ == nil) {
    activeCallViewController_
      = [[ActiveTransferCallViewController alloc] initWithCallController:self];
    [activeCallViewController_ setRepresentedObject:[self call]];
  }
  return activeCallViewController_;
}

// Substitutes EndedTransferCallViewController.
- (EndedCallViewController *)endedCallViewController {
  if (endedCallViewController_ == nil) {
    endedCallViewController_
      = [[EndedTransferCallViewController alloc] initWithCallController:self];
    [endedCallViewController_ setRepresentedObject:[self call]];
  }
  return endedCallViewController_;
}

- (void)acceptCall {
  // Do nothing.
}

@end