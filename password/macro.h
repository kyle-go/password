//
// macro.h
//
// create by kyle. 2013.11
// https://gist.github.com/kylescript/7332390

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define STR(key) NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME NSHomeDirectory()
#define PATH_OF_TEMP NSTemporaryDirectory()
#define PATH_OF_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
