#include <jni.h>
#include <stdio.h>
#include "HelloWorld.h"

JNIEXPORT void JNICALL
Java_HelloWorld_greet(JNIEnv *env, jobject obj) {
    printf("Hello world; this is C talking!\n");
    return;
}
