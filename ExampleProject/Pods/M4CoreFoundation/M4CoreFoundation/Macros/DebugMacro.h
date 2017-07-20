//
//  DebugMacro.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

///////////////////////////////////////////////////////////////////////////////////////////////////

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

///////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d  \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
