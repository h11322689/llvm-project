/*************************************************************************
	> File Name: MyRISCVTargetMachine.cpp
	> Author: LJM
	> Mail: ljm@ljm.com 
	> Created Time: 2024年08月13日 星期二 11时00分24秒
 ************************************************************************/

#include "llvm/Support/Compiler.h"

// llc后端都必须实现各自的 void LLVMInitializeMyRISCVTarget(),否则会报错“undefined reference to 'LLVMInitializeMyRISCVTarget'”
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeMyRISCVTarget() {}



