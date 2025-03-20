#include <jni.h>
#include <stdio.h>
#include "net_ingy_HelloWorld.h"

JNIEXPORT void JNICALL
Java_net_ingy_HelloWorld_greet(JNIEnv *env, jobject obj) {
    printf("Hello world; this is C talking!\n");
    return;
}
