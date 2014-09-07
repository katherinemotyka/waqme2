

#import "HttpWrapper.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "NSObject+SBJSON.h"
#import "SBJSON.h"

@implementation HttpWrapper

AppDelegate *appDelegate;

@synthesize delegate, fetchSuccess, fetchFail;

-(id)initWithDelegate:(id)del {
    self = [super init];
    if(self) {
        delegate = del;
        appDelegate = [AppDelegate sharedDalegate];
    }
    return self;
}

-(void) requestWithMethod:(NSString*)method url:(NSString*)strUrl param:(NSMutableDictionary*)dictParam selSuc:(SEL)forSuc selFail:(SEL)forFail
{
    fetchSuccess = forSuc;
    
    fetchFail = forFail;
    //isImage = FALSE;
    
    NSLog(@"HttpWrapper method:%@ >> %@ ", method, strUrl);
    NSLog(@"%@",dictParam);
    
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *jsonString = [jsonWriter stringWithObject:dictParam];
    NSLog(@"jsonString   >>>>>> %@",jsonString);
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    ASIFormDataRequest *requestMain = [ASIFormDataRequest requestWithURL:url];
    

    [requestMain addRequestHeader:@"Content-Type" value:@"application/json"];
    [requestMain addRequestHeader:@"Accept" value:@"application/json"];

    
//    headers.put("Accept", "application/json");
//    headers.put("Contenttype", "application/json");
    
    
    NSMutableData *datas = [[NSMutableData alloc]initWithData:requestData];
    
    [requestMain setPostBody:datas];
    [requestMain addRequestHeader:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonString length]] value:@"Content-Length"];
    [requestMain setRequestMethod:method];
    
    [requestMain setDelegate:self];
    [requestMain startAsynchronous];
    [requestMain setValidatesSecureCertificate:NO];
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSString *responseString = [request responseString];
    NSLog(@"HttpWrapper > requestFinished > %@",responseString);

    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *dic = (NSDictionary *)[parser objectWithString:responseString error:nil];
    
    if([delegate respondsToSelector:fetchSuccess])
        [delegate performSelector:fetchSuccess withObject:dic];
    
    request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"HttpWrapper > requestFailed > error: %@",error);
    
    request = nil;
    
    if([delegate respondsToSelector:fetchFail])
        [delegate performSelector:fetchFail withObject:error];
}

-(void) requestWithImageUrl:(NSString*)strUrl {

    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSString *filePath = [appDelegate applicationCacheDirectory] ;
    filePath = [filePath stringByAppendingPathComponent:[url lastPathComponent]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath] == YES) {
        if([delegate respondsToSelector:@selector(fetchImageSuccess:)])
            [delegate performSelector:@selector(fetchImageSuccess:) withObject:filePath];
        
        return;
    }
    
    ASIFormDataRequest *requestMain = [ASIHTTPRequest requestWithURL:url];
    [requestMain setDidFinishSelector:@selector(requestFinishedImage:)];
    [requestMain setDidFailSelector:@selector(requestFinishedImage:)];
    [requestMain setDownloadDestinationPath:filePath];
  //  [requestMain setShouldContinueWhenAppEntersBackground:YES];
    [requestMain setDelegate:self];
    [requestMain startAsynchronous];
}

-(void) requestWithImageUrl:(NSString*)strUrl toFolder:(NSString*)folderName venueName:(NSString*)vn{
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSString *filePath = [[appDelegate applicationCacheDirectory] stringByAppendingPathComponent:folderName];
    
    filePath = [filePath stringByAppendingPathComponent:[vn stringByAppendingString:@".png"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath] == YES) {
        if([delegate respondsToSelector:@selector(fetchImageSuccess:)])
            [delegate performSelector:@selector(fetchImageSuccess:) withObject:filePath];
        
        return;
    }
    
    ASIFormDataRequest *requestMain = [ASIHTTPRequest requestWithURL:url];
    [requestMain setDidFinishSelector:@selector(requestFinishedImage:)];
    [requestMain setDidFailSelector:@selector(requestFinishedImage:)];
    [requestMain setDownloadDestinationPath:filePath];
   // [requestMain setShouldContinueWhenAppEntersBackground:YES];
    [requestMain setDelegate:self];
    [requestMain startAsynchronous];
}

- (void)requestFinishedImage:(ASIHTTPRequest *)request
{
    //NSData *responseData = [request responseData];
    if([delegate respondsToSelector:@selector(fetchImageSuccess:)])
        [delegate performSelector:@selector(fetchImageSuccess:) withObject:[request downloadDestinationPath]];
    
    request = nil;
}

- (void)requestFailedImage:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"HttpWrapper > requestFailedImage > error: %@",error);
    
    request = nil;
    
    
    if([delegate respondsToSelector:@selector(fetchImageFail:)])
        [delegate performSelector:@selector(fetchImageFail:) withObject:error];
    
}


//-(void) cancelRequest {
//    if([requestMain isExecuting]) {
//        requestMain.delegate = nil;
//        [requestMain cancel];
//    }
//}



@end
